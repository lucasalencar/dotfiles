import { test } from "node:test"
import assert from "node:assert/strict"
import { TmuxAgentStatusPlugin } from "../plugins/tmux-agent-status.ts"

type FakeSession = { id: string; parentID?: string }

const captureShell = (calls: string[]): any =>
  async (strings: TemplateStringsArray, ...values: unknown[]) => {
    calls.push(strings.reduce((acc, s, i) => acc + s + (i < values.length ? String(values[i]) : ""), ""))
  }

const makeClient = (sessions: Record<string, FakeSession> = {}) => ({
  session: {
    get: async ({ path }: { path: { id: string } }) => ({ data: sessions[path.id] ?? { id: path.id } }),
  },
})

const makePlugin = async (calls: string[], sessions?: Record<string, FakeSession>) => {
  const plugin = await TmuxAgentStatusPlugin({
    client: makeClient(sessions),
    $: captureShell(calls),
    project: {},
    directory: "",
    worktree: "",
    serverUrl: new URL("http://localhost:4096"),
    experimental_workspace: {},
  } as any)
  return async (event: Record<string, unknown>) => {
    await plugin.event?.({ event } as any)
  }
}

const flush = () => new Promise<void>((r) => setImmediate(r))

test("main session busy → tmux-agent-state running", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "busy" } } })
  assert.deepEqual(calls, ["tmux-agent-state running OpenCode"])
})

test("main session idle → tmux-agent-state idle", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "idle" } } })
  assert.deepEqual(calls, ["tmux-agent-state idle OpenCode"])
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "busy" } } })
})

test("child session busy/idle → subagent-start/stop with JSON on stdin", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.created", properties: { info: { id: "child-1", parentID: "main" } } })
  await fire({ type: "session.status", properties: { sessionID: "child-1", status: { type: "busy" } } })
  await fire({ type: "session.status", properties: { sessionID: "child-1", status: { type: "idle" } } })
  assert.deepEqual(calls, [
    `echo {"session_id":"child-1"} | tmux-agent-state subagent-start`,
    `echo {"session_id":"child-1"} | tmux-agent-state subagent-stop`,
  ])
})

test("child classification goes through client.session.get when session.created was missed", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls, { "child-1": { id: "child-1", parentID: "main" } })
  await fire({ type: "session.status", properties: { sessionID: "child-1", status: { type: "busy" } } })
  assert.deepEqual(calls, [`echo {"session_id":"child-1"} | tmux-agent-state subagent-start`])
})

test("session lookup failure falls back to root (main) behavior", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls, {})
  await fire({ type: "session.status", properties: { sessionID: "unknown", status: { type: "busy" } } })
  assert.deepEqual(calls, ["tmux-agent-state running OpenCode"])
})

test("waiting flow sends waiting state, tmux notify and agent-notify", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "permission.asked", properties: { sessionID: "main" } })
  assert.deepEqual(calls, [
    "tmux-agent-state waiting OpenCode",
    "tmux-notify-window",
    `echo {"notification_type":"waiting","message":"OpenCode is waiting for your input"} | agent-notify "OpenCode"`,
  ])
})

test("main session error sends error state, tmux notify and agent-notify with error message", async () => {
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.error", properties: { sessionID: "main", error: { message: "boom" } } })
  assert.deepEqual(calls, [
    "tmux-agent-state error OpenCode",
    "tmux-notify-window",
    `echo {"notification_type":"error","message":"boom"} | agent-notify "OpenCode"`,
  ])
})

test("done notification fires 10s after the session goes idle", async (t) => {
  t.mock.timers.enable({ apis: ["setTimeout"] })
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "idle" } } })
  await t.mock.timers.tick(9999)
  assert.deepEqual(calls, ["tmux-agent-state idle OpenCode"])
  await t.mock.timers.tick(1)
  await flush()
  assert.deepEqual(calls, [
    "tmux-agent-state idle OpenCode",
    "tmux-notify-window",
    `echo {"notification_type":"done","message":"Session completed"} | agent-notify "OpenCode"`,
  ])
})

test("pending done notification is cancelled when the session turns busy again", async (t) => {
  t.mock.timers.enable({ apis: ["setTimeout"] })
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "idle" } } })
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "busy" } } })
  await t.mock.timers.tick(10000)
  await flush()
  assert.deepEqual(calls, ["tmux-agent-state idle OpenCode", "tmux-agent-state running OpenCode"])
})

test("done notification is rescheduled on consecutive idle events", async (t) => {
  t.mock.timers.enable({ apis: ["setTimeout"] })
  const calls: string[] = []
  const fire = await makePlugin(calls)
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "idle" } } })
  await t.mock.timers.tick(9000)
  await fire({ type: "session.status", properties: { sessionID: "main", status: { type: "idle" } } })
  await t.mock.timers.tick(9999)
  assert.deepEqual(calls, ["tmux-agent-state idle OpenCode", "tmux-agent-state idle OpenCode"])
  await t.mock.timers.tick(1)
  await flush()
  assert.deepEqual(calls, [
    "tmux-agent-state idle OpenCode",
    "tmux-agent-state idle OpenCode",
    "tmux-notify-window",
    `echo {"notification_type":"done","message":"Session completed"} | agent-notify "OpenCode"`,
  ])
})
