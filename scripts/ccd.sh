#!/bin/bash

source "$DOTFILES_ROOT/scripts/fzf-tmux-helpers.sh"

ccd () {
  local base_dir
  base_dir=$(resolve_code_home)

  project=$(ls --color=never "$base_dir" | fzf)
  if [ "$project" ]
  then
    cd "$base_dir/$project" || return
  fi
}
