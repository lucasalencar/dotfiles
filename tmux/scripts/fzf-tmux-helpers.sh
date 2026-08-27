#!/bin/bash

source "$DOTFILES_ROOT/scripts/helpers.sh"

# Scripts sourcing this file run via `run-shell`, whose cwd is the tmux
# server's own cwd, not the active pane's. `fzf-tmux` opens its split-window
# with `-c "$PWD"`, so without this the split lands in the wrong directory
# and automatic-rename briefly (or permanently) renames the current window
# to that directory's basename instead of the pane's actual project.
cd "$(tmux display-message -p '#{pane_current_path}')" 2>/dev/null || true

fzf_tmux_window_index () {
  window_list=$(tmux list-windows -F "#I: #{window_name} - #{pane_current_path}")
  selected_window=$(echo "$window_list" | fzf-tmux)
  WINDOW_INDEX=$(echo "$selected_window" | cut -d ":" -f 1)
  echo "$WINDOW_INDEX"
}

tmux_current_window_index () {
  current_index=$(tmux display-message -p '#I')
  echo "$current_index"
}

fzf_tmux_code_dir () {
  local base_dir
  base_dir=$(resolve_code_home)
  ls "$base_dir" | fzf-tmux \
    --preview "bat --style=plain --color=always $base_dir/{}/README.md"
}
