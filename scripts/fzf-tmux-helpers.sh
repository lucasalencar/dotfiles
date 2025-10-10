#!/bin/bash

resolve_code_home () {
  local base_dir
  base_dir="${CODE_HOME:-$HOME/code}"
  # Expand ~ if present
  base_dir=$(eval echo "$base_dir")
  echo "$base_dir"
}

fzf_tmux_window_index () {
  selected_window=$(tmux list-windows -F "#I: #{pane_current_path}" | fzf-tmux)
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
  ls "$base_dir" | fzf-tmux
}
