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

  let doneTimer: ReturnType<typeof setTimeout> | null = null

  const scheduleDoneNotification = () => {
    if (doneTimer) clearTimeout(doneTimer)
    doneTimer = setTimeout(async () => {
      await notifyTmux()
      await sendNotification("done", "Session completed")
    }, 10000)
  }

  const cancelDoneNotification = () => {
    if (doneTimer) {
      clearTimeout(doneTimer)
      doneTimer = null
    }
  }

  return {
    event: async ({ event }) => {
      const sendNotification = async (notificationType: string, message: string) => {
        try {
          const jsonPayload = JSON.stringify({ notification_type: notificationType, message })
          await $`echo ${jsonPayload} | agent-notify "OpenCode"`
        } catch (err) {
          console.error("sendNotification failed:", err)
        }
      }

      const notifyTmux = async () => {
        try {
          await $`tmux-notify-window`
        } catch (err) {
          console.error("tmux-notify-window failed:", err)
        }
      }

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
          cancelDoneNotification()
          await setState("error")
          await notifyTmux()
          await sendNotification("error", event.properties?.message || "Session error occurred")
          break

        case "tui.prompt.append":
        case "permission.asked":
        case "permission.updated":
          cancelDoneNotification()
          await setState("waiting")
          await notifyTmux()
          await sendNotification("waiting", "OpenCode is waiting for your input")
          break

        case "permission.replied":
          cancelDoneNotification()
          await setState("running")
          await notifyTmux()
          break

        case "session.status":
          if (event.properties?.status?.type === "busy") {
            cancelDoneNotification()
            await setState("running")
            await notifyTmux()
          } else if (event.properties?.status?.type === "idle") {
            await setState("idle")
            await notifyTmux()
            scheduleDoneNotification()
          }
          break
      }
    },
  }
}
