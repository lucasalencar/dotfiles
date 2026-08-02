// Pure state machine for the tmux agent status plugin.
//
// No I/O here: session classification is injected via `classify`, and side
// effects (shell commands, timers, notifications) are returned as declarative
// actions for the adapter to execute. This module is dependency-free so it can
// be unit-tested with node:test without any setup.

export type AgentEvent = {
  type: string
  properties?: Record<string, unknown>
}

export type AgentKind = "root" | "child"

export type ClassifyFn = (sessionID: string) => Promise<AgentKind>

export type Action =
  | { type: "set-state"; state: "running" | "waiting" | "idle" | "error" }
  | { type: "subagent"; op: "subagent-start" | "subagent-stop"; sessionID: string }
  | { type: "notify-tmux" }
  | { type: "notify"; kind: "done" | "error" | "waiting"; message: string }
  | { type: "schedule-done" }
  | { type: "cancel-done" }

export type StatusTracker = {
  handle(event: AgentEvent): Promise<Action[]>
  isSubagentActive(sessionID: string): boolean
  activeSubagentCount(): number
}

export function createStatusTracker(classify: ClassifyFn): StatusTracker {
  const sessionKind = new Map<string, AgentKind>()
  const activeSubagents = new Set<string>()
  let messageCompleted = false

  const classifySession = async (sessionID: string): Promise<AgentKind> => {
    const known = sessionKind.get(sessionID)
    if (known) return known
    const kind = await classify(sessionID)
    sessionKind.set(sessionID, kind)
    return kind
  }

  const props = (event: AgentEvent): Record<string, any> => event.properties ?? {}

  const sessionIDOf = (event: AgentEvent): string | undefined => {
    const p = props(event)
    return (p.sessionID ?? p.info?.sessionID ?? p.info?.id) as string | undefined
  }

  const doneActions = (): Action[] => [
    { type: "set-state", state: "idle" },
    { type: "schedule-done" },
  ]

  const handle = async (event: AgentEvent): Promise<Action[]> => {
    const p = props(event)
    const sessionID = sessionIDOf(event)

    switch (event.type) {
      case "session.created": {
        const info = p.info as { id?: string; parentID?: string } | undefined
        if (info?.id && info.parentID) sessionKind.set(info.id, "child")
        return []
      }

      case "message.updated": {
        if (sessionID && (await classifySession(sessionID)) === "child") return []
        const info = p.info as { role?: string; finish?: string } | undefined
        if (info?.role !== "assistant") return []
        if (info.finish) {
          messageCompleted = true
          return doneActions()
        }
        messageCompleted = false
        return [{ type: "set-state", state: "running" }]
      }

      case "session.error": {
        const actions: Action[] = [{ type: "cancel-done" }]
        if (sessionID && (await classifySession(sessionID)) === "child") {
          if (activeSubagents.delete(sessionID)) {
            actions.push({ type: "subagent", op: "subagent-stop", sessionID })
          }
          return actions
        }
        const error = p.error as { message?: string } | undefined
        actions.push(
          { type: "set-state", state: "error" },
          { type: "notify-tmux" },
          { type: "notify", kind: "error", message: error?.message ?? "Session error occurred" },
        )
        return actions
      }

      case "session.status": {
        const status = p.status as { type?: string } | undefined
        if (!sessionID || !status) return []
        if ((await classifySession(sessionID)) === "child") {
          if (status.type === "busy") {
            if (activeSubagents.has(sessionID)) return []
            activeSubagents.add(sessionID)
            return [{ type: "subagent", op: "subagent-start", sessionID }]
          }
          if (status.type === "idle" && activeSubagents.delete(sessionID)) {
            return [{ type: "subagent", op: "subagent-stop", sessionID }]
          }
          return []
        }
        if (status.type === "busy") {
          const actions: Action[] = []
          if (!messageCompleted) actions.push({ type: "set-state", state: "running" })
          actions.push({ type: "cancel-done" })
          return actions
        }
        if (status.type === "idle") return doneActions()
        return []
      }

      case "session.deleted": {
        if (sessionID && activeSubagents.delete(sessionID)) {
          return [{ type: "subagent", op: "subagent-stop", sessionID }]
        }
        return []
      }

      case "tui.prompt.append":
      case "permission.asked":
      case "permission.updated": {
        messageCompleted = false
        return [
          { type: "cancel-done" },
          { type: "set-state", state: "waiting" },
          { type: "notify-tmux" },
          { type: "notify", kind: "waiting", message: "OpenCode is waiting for your input" },
        ]
      }

      case "permission.replied": {
        messageCompleted = false
        return [{ type: "cancel-done" }, { type: "set-state", state: "running" }]
      }

      default:
        return []
    }
  }

  return {
    handle,
    isSubagentActive: (sessionID) => activeSubagents.has(sessionID),
    activeSubagentCount: () => activeSubagents.size,
  }
}
