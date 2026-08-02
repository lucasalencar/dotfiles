import { test } from "node:test"
import assert from "node:assert/strict"
import { createStatusTracker, type Action, type AgentEvent, type AgentKind } from "../lib/tmux-agent-status-core.ts"

const rootClassify = async (): Promise<AgentKind> => "root"

const ev = (type: string, properties: Record<string, unknown> = {}): AgentEvent => ({ type, properties })

const statusEvent = (type: string, sessionID: string, status: string): AgentEvent =>
  ev(type, { sessionID, status: { type: status } })

const messageUpdated = (properties: Record<string, unknown>): AgentEvent => ev("message.updated", properties)

const noActions: Action[] = []

test("main session busy → set running and cancel done timer", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "main", "busy")), [
    { type: "set-state", state: "running" },
    { type: "cancel-done" },
  ])
})

test("main session idle → set idle and schedule done notification", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "main", "idle")), [
    { type: "set-state", state: "idle" },
    { type: "schedule-done" },
  ])
})

test("child session busy → subagent-start (pre-registered via session.created)", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "busy")), [
    { type: "subagent", op: "subagent-start", sessionID: "child-1" },
  ])
  assert.equal(tracker.isSubagentActive("child-1"), true)
})

test("child session idle → subagent-stop", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  await tracker.handle(statusEvent("session.status", "child-1", "busy"))
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "idle")), [
    { type: "subagent", op: "subagent-stop", sessionID: "child-1" },
  ])
  assert.equal(tracker.activeSubagentCount(), 0)
})

test("child session classified on demand when session.created was not seen", async () => {
  let calls = 0
  const classify = async (sessionID: string): Promise<AgentKind> => {
    calls++
    return sessionID === "child-1" ? "child" : "root"
  }
  const tracker = createStatusTracker(classify)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "busy")), [
    { type: "subagent", op: "subagent-start", sessionID: "child-1" },
  ])
  assert.equal(calls, 1)

  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "busy")), noActions)
  assert.equal(calls, 1, "classification result must be cached")
})

test("repeated child busy is deduplicated; start→stop→start cycles cleanly", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "busy")), [
    { type: "subagent", op: "subagent-start", sessionID: "child-1" },
  ])
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "busy")), noActions)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "idle")), [
    { type: "subagent", op: "subagent-stop", sessionID: "child-1" },
  ])
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "busy")), [
    { type: "subagent", op: "subagent-start", sessionID: "child-1" },
  ])
})

test("main session idle while a subagent is still active still reports idle (tmux recomputes display)", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  await tracker.handle(statusEvent("session.status", "child-1", "busy"))
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "main", "idle")), [
    { type: "set-state", state: "idle" },
    { type: "schedule-done" },
  ])
})

test("message.updated assistant without finish → running", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(
    await tracker.handle(messageUpdated({ info: { sessionID: "main", role: "assistant" } })),
    [{ type: "set-state", state: "running" }],
  )
})

test("message.updated assistant with finish → idle + schedule done", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(
    await tracker.handle(messageUpdated({ info: { sessionID: "main", role: "assistant", finish: "stop" } })),
    [
      { type: "set-state", state: "idle" },
      { type: "schedule-done" },
    ],
  )
})

test("message.updated for a child session is ignored", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  assert.deepEqual(
    await tracker.handle(messageUpdated({ info: { sessionID: "child-1", role: "assistant", finish: "stop" } })),
    noActions,
  )
})

test("message.updated for non-assistant messages is ignored", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(await tracker.handle(messageUpdated({ info: { sessionID: "main", role: "user" } })), noActions)
})

test("completed main message suppresses running on later busy status", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(messageUpdated({ info: { sessionID: "main", role: "assistant", finish: "stop" } }))
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "main", "busy")), [
    { type: "cancel-done" },
  ])
})

test("permission.replied resets the completed flag and sets running", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(messageUpdated({ info: { sessionID: "main", role: "assistant", finish: "stop" } }))
  assert.deepEqual(await tracker.handle(ev("permission.replied", { sessionID: "main" })), [
    { type: "cancel-done" },
    { type: "set-state", state: "running" },
  ])
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "main", "busy")), [
    { type: "set-state", state: "running" },
    { type: "cancel-done" },
  ])
})

test("main session error → cancel done, error state, tmux notify, error notification", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(await tracker.handle(ev("session.error", { sessionID: "main", error: { message: "boom" } })), [
    { type: "cancel-done" },
    { type: "set-state", state: "error" },
    { type: "notify-tmux" },
    { type: "notify", kind: "error", message: "boom" },
  ])
})

test("main session error without message uses fallback text", async () => {
  const tracker = createStatusTracker(rootClassify)
  const actions = await tracker.handle(ev("session.error", { sessionID: "main" }))
  assert.deepEqual(actions.at(-1), { type: "notify", kind: "error", message: "Session error occurred" })
})

test("error on an active child session → subagent-stop, main untouched", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  await tracker.handle(statusEvent("session.status", "child-1", "busy"))
  assert.deepEqual(await tracker.handle(ev("session.error", { sessionID: "child-1" })), [
    { type: "cancel-done" },
    { type: "subagent", op: "subagent-stop", sessionID: "child-1" },
  ])
  assert.equal(tracker.activeSubagentCount(), 0)
})

test("error on an inactive child session does not emit subagent-stop", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  assert.deepEqual(await tracker.handle(ev("session.error", { sessionID: "child-1" })), [
    { type: "cancel-done" },
  ])
})

test("waiting triggers (tui.prompt.append, permission.asked, permission.updated) → waiting flow", async () => {
  const tracker = createStatusTracker(rootClassify)
  const expected = [
    { type: "cancel-done" },
    { type: "set-state", state: "waiting" },
    { type: "notify-tmux" },
    { type: "notify", kind: "waiting", message: "OpenCode is waiting for your input" },
  ]
  for (const type of ["tui.prompt.append", "permission.asked", "permission.updated"]) {
    assert.deepEqual(await tracker.handle(ev(type, { sessionID: "main" })), expected)
  }
})

test("deleted active child session → subagent-stop", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "child-1", parentID: "main" } }))
  await tracker.handle(statusEvent("session.status", "child-1", "busy"))
  assert.deepEqual(await tracker.handle(ev("session.deleted", { info: { id: "child-1", parentID: "main" } })), [
    { type: "subagent", op: "subagent-stop", sessionID: "child-1" },
  ])
})

test("deleted inactive child session → no actions", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(
    await tracker.handle(ev("session.deleted", { info: { id: "child-1", parentID: "main" } })),
    noActions,
  )
})

test("unknown session events are ignored", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "child-1", "retry")), noActions)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "main", "retry")), noActions)
  assert.deepEqual(await tracker.handle(ev("session.status", {})), noActions)
  assert.deepEqual(await tracker.handle(ev("session.unknown", { sessionID: "main" })), noActions)
})

test("child busy when classify says root (e.g. lookup failure) drives the main state", async () => {
  const tracker = createStatusTracker(rootClassify)
  assert.deepEqual(await tracker.handle(statusEvent("session.status", "any-session", "busy")), [
    { type: "set-state", state: "running" },
    { type: "cancel-done" },
  ])
})

test("parallel subagents each tracked independently", async () => {
  const tracker = createStatusTracker(rootClassify)
  await tracker.handle(ev("session.created", { info: { id: "a", parentID: "main" } }))
  await tracker.handle(ev("session.created", { info: { id: "b", parentID: "main" } }))
  await tracker.handle(statusEvent("session.status", "a", "busy"))
  await tracker.handle(statusEvent("session.status", "b", "busy"))
  assert.equal(tracker.activeSubagentCount(), 2)
  await tracker.handle(statusEvent("session.status", "a", "idle"))
  assert.equal(tracker.activeSubagentCount(), 1)
  assert.equal(tracker.isSubagentActive("b"), true)
})
