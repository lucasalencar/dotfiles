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
- `scripts/tmux-on-select-window` clears "seen" states (`waiting`/`idle`/`error`)
  when you focus a window, keeping `running` ones — so `○` stays until you look.

Integration points (both call `tmux-agent-state`):

- Claude Code: hooks in `~/.claude/settings.json` (`UserPromptSubmit` → running,
  `AskUserQuestion`/`permission_prompt` → waiting, `Stop` → idle,
  `SessionEnd` → clear).
- OpenCode: `opencode/.config/opencode/plugins/notification.ts` event handler.

## TODO

- [ ] Update catppuccin theme configuration and unpin 0.3.0 version
    https://github.com/catppuccin/tmux/issues/291
    https://github.com/catppuccin/tmux?tab=readme-ov-file#recommended-default-configuration
