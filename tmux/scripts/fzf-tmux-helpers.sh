#!/bin/bash

source "$DOTFILES_ROOT/scripts/helpers.sh"

fzf_tmux_window_index () {
  window_list=$(tmux list-windows -F "#I|#{window_id}|#{pane_current_path}" | while IFS='|' read -r index window_id path; do
    label=$("$DOTFILES_ROOT/tmux/scripts/tmux-window-label" "$window_id")
    printf '%s: %s - %s\n' "$index" "$label" "$path"
  done)
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
