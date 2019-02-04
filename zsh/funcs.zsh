ncd () {
  PROJECT=$(ls $NU_HOME | fzf)
  cd "$NU_HOME/$PROJECT"
}

fgb () {
  BRANCH=$(git branch | cut -c 3- | fzf)
  git checkout $BRANCH
}

vf () {
  FILE=$(fzf)
  nvim $FILE
}

fzf_tmux_window_index () {
  selected_window=$(tmux list-windows -F "#I: #{pane_current_path}" | fzf-tmux)
  WINDOW_INDEX=$(echo "$selected_window" | cut -d ":" -f 1)
  echo $WINDOW_INDEX
  return $WINDOW_INDEX
}

fzf_tmux_select_window () {
  fzf_tmux_window_index | xargs tmux select-window -t
}

tmux_current_window_index () {
  current_index=$(tmux display-message -p '#I')
  echo $current_index
  return $current_index
}

fzf_tmux_swap_window_closer () {
  current_window=$(tmux_current_window_index)
  incremented=$((current_window + 1))

  selected_window=$(fzf_tmux_window_index)

  tmux swap-window -s $selected_window -t $incremented
  tmux move-window -r # Renumbers all windows according to order
}
