# tmux package

## Coding agent status

Status icons of coding agents (Claude Code, OpenCode) are shown in each tmux
window name: `●` running, `◐` waiting for input, `✕` error, `○` done/idle.
This replaces the `hiroppy/tmux-agent-sidebar` plugin without an external binary.

How it works:

- `scripts/tmux-agent-state <running|waiting|idle|error|clear> [agent_name]` is
  the shared writer. It resolves the agent's pane from `$TMUX_PANE` and sets the
  `@pane_status` pane option (the "database" is the tmux server itself —
  pane → window → session is derivable). Because it is called bare from agent
  hooks, it is symlinked into the `scripts` package (which is on `PATH`):
  `scripts/tmux-agent-state -> ../tmux/scripts/tmux-agent-state`, like
  `tmux-notify-window`.
- `scripts/tmux-agent-icon` reads `@pane_status` and renders the icons in the
  window name (wired into `@catppuccin_window_text` in `.tmux.conf`).
- `scripts/tmux-clear-stale-status` runs on `after-select-window` and
  `after-select-pane`. It compares the recorded command (`@pane_command`, stored
  by `tmux-agent-state`) against the pane's current command — if they differ,
  the agent process has exited and the stale status is cleared. Works for any
  coding agent without a hardcoded allowlist. Legacy panes (no `@pane_command`)
  fall back to checking if the current command is a known shell.
- `scripts/tmux-on-select-window` orchestrates stale cleanup and notification
  clearing when you focus a window.

Integration points (both call `tmux-agent-state`):

- Claude Code: hooks in `~/.claude/settings.json` (`UserPromptSubmit` → running,
  `AskUserQuestion`/`permission_prompt` → waiting, `Stop` → idle,
  `SessionEnd` → clear).
- OpenCode: `opencode/.config/opencode/plugins/tmux-agent-status.ts` event
  handler.
