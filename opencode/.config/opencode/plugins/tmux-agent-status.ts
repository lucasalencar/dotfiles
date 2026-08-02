import type { Plugin } from "@opencode-ai/plugin"
import { createStatusTracker, type Action, type AgentEvent } from "../lib/tmux-agent-status-core.ts"

export const TmuxAgentStatusPlugin: Plugin = async ({ client, $ }) => {
  const DEBUG = process.env.TMUX_AGENT_STATUS_DEBUG === "true"
  const logFile = "/tmp/tmux-agent-status.log"

  const log = async (msg: string) => {
    if (!DEBUG) return
    try {
      await $`echo "${msg}" >> ${logFile}`
    } catch {}
  }

  // Sessions spawned by the task tool are child sessions (parentID set). Their
  // busy/idle events drive `tmux-agent-state subagent-start/stop`, which keeps
  // the pane status "running" while subagents are active even when the main
  // session is idle. All other (root) sessions drive the main status.
  const tracker = createStatusTracker(async (sessionID) => {
    try {
      const result = await client.session.get({ path: { id: sessionID } })
      return result.data?.parentID ? "child" : "root"
    } catch (err) {
      console.error("session.get failed:", err)
      return "root"
    }
  })

  let doneTimer: ReturnType<typeof setTimeout> | null = null

  const execute = async (action: Action): Promise<void> => {
    switch (action.type) {
      case "set-state":
        try {
          await $`tmux-agent-state ${action.state} OpenCode`
        } catch (err) {
          console.error("tmux-agent-state failed:", err)
        }
        break

      case "subagent":
        try {
          const jsonPayload = JSON.stringify({ session_id: action.sessionID })
          await $`echo ${jsonPayload} | tmux-agent-state ${action.op}`
        } catch (err) {
          console.error(`tmux-agent-state ${action.op} failed:`, err)
        }
        break

      case "notify-tmux":
        try {
          await $`tmux-notify-window`
        } catch (err) {
          console.error("tmux-notify-window failed:", err)
        }
        break

      case "notify":
        try {
          const jsonPayload = JSON.stringify({ notification_type: action.kind, message: action.message })
          await $`echo ${jsonPayload} | agent-notify "OpenCode"`
        } catch (err) {
          console.error("sendNotification failed:", err)
        }
        break

      case "schedule-done":
        if (doneTimer) clearTimeout(doneTimer)
        doneTimer = setTimeout(() => {
          void execute({ type: "notify-tmux" })
          void execute({ type: "notify", kind: "done", message: "Session completed" })
        }, 10000)
        break

      case "cancel-done":
        if (doneTimer) {
          clearTimeout(doneTimer)
          doneTimer = null
        }
        break
    }
  }

  return {
    event: async ({ event }) => {
      await log(`${event.type} ${JSON.stringify(event.properties)}`)
      for (const action of await tracker.handle(event as AgentEvent)) {
        await execute(action)
      }
    },
  }
}
