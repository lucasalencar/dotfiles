import type { Plugin } from "@opencode-ai/plugin"

export const TmuxAgentStatusPlugin: Plugin = async ({ client, $ }) => {
  const DEBUG = process.env.TMUX_AGENT_STATUS_DEBUG === "true"
  const logFile = "/tmp/tmux-agent-status.log"

  const log = async (msg: string) => {
    if (!DEBUG) return
    try {
      await $`echo "${msg}" >> ${logFile}`
    } catch {}
  }

  return {
    event: async ({ event }) => {
      const sendNotification = async (notificationType: string, message: string) => {
        const jsonPayload = JSON.stringify({ notification_type: notificationType, message })
        await $`echo ${jsonPayload} | agent-notify "OpenCode"`
      }

      const notifyTmux = async () => {
        try {
          await $`tmux-notify-window`
        } catch (err) {
          console.error("tmux-notify-window failed:", err)
        }
      }

      // Updates the per-pane agent status icon in the tmux window name
      // (running/waiting/idle/error), via the shared tmux-agent-state writer.
      const setState = async (state: string) => {
        try {
          await $`tmux-agent-state ${state} OpenCode`
        } catch (err) {
          console.error("tmux-agent-state failed:", err)
        }
      }

      await log(`${event.type} ${JSON.stringify(event.properties)}`)

      switch (event.type) {
        case "session.error":
          await setState("error")
          await notifyTmux()
          await sendNotification("error", event.properties?.message || "Session error occurred")
          break

        case "session.idle":
          await setState("idle")
          await notifyTmux()
          await sendNotification("done", "Session completed")
          break

        case "tui.prompt.append":
        case "permission.asked":
        case "permission.updated":
          await setState("waiting")
          await notifyTmux()
          await sendNotification("waiting", "OpenCode is waiting for your input")
          break

        case "permission.replied":
          await setState("running")
          await notifyTmux()
          break

        case "session.status":
          if (event.properties?.status?.type === "busy") {
            await setState("running")
            await notifyTmux()
          }
          break
      }
    },
  }
}
