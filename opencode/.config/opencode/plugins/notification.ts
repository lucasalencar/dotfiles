import type { Plugin } from "@opencode-ai/plugin"

export const NotificationPlugin: Plugin = async ({ client, $ }) => {
  return {
    event: async ({ event }) => {
      const sendNotification = async (notificationType: string, message: string) => {
        const jsonPayload = JSON.stringify({ notification_type: notificationType, message, agent_name: "OpenCode" })
        await $`echo ${jsonPayload} | agent-notify`
      }

      const notifyTmux = async () => {
        try {
          await $`tmux-notify-window`
        } catch (err) {
          console.error("tmux-notify-window failed:", err)
        }
      }

      switch (event.type) {
        case "session.error":
          await notifyTmux()
          await sendNotification("error", event.data?.message || "Session error occurred")
          break

        case "session.idle":
          await notifyTmux()
          await sendNotification("done", "Session completed")
          break

        case "tui.prompt.append":
          await notifyTmux()
          await sendNotification("waiting", "OpenCode is waiting for your input")
          break

        case "session.status":
          if (event.data?.status === "busy") {
            await notifyTmux()
          }
          break
      }
    },
  }
}
