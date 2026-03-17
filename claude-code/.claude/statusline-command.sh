#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

user=$(whoami)
host=$(hostname -s)

# Shorten home directory to ~
short_dir="${cwd/#$HOME/\~}"

# Git branch (skip optional locks)
git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

# Build status parts
printf " \033[0;37m%s\033[0m" "$short_dir"

if [ -n "$git_branch" ]; then
  printf " \033[0;33m(%s)\033[0m" "$git_branch"
fi

if [ -n "$model" ]; then
  printf " \033[0;36m[%s]\033[0m" "$model"
fi

if [ -n "$used_pct" ]; then
  printf " \033[0;35mctx:%s%%\033[0m" "$used_pct"
fi

printf "\n"
