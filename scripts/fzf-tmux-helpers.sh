#!/bin/bash

fzf_tmux_window_index () {
  selected_window=$(tmux list-windows -F "#I: #{pane_current_path}" | fzf-tmux)
  WINDOW_INDEX=$(echo "$selected_window" | cut -d ":" -f 1)
  echo "$WINDOW_INDEX"
}

tmux_current_window_index () {
  current_index=$(tmux display-message -p '#I')
  echo $current_index
  return $current_index
}

fzf_tmux_code_dir () {
  ls $CODE_HOME | fzf-tmux
}
