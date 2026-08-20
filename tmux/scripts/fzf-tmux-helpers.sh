#!/bin/bash

source "$DOTFILES_ROOT/scripts/helpers.sh"

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
