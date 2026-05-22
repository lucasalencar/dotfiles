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

  diff_stats=$(git -C "$cwd" --no-optional-locks diff HEAD --shortstat 2>/dev/null)
  added=$(echo "$diff_stats" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
  removed=$(echo "$diff_stats" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')
  added=${added:-0}
  removed=${removed:-0}
  if [ "$added" != "0" ] || [ "$removed" != "0" ]; then
    printf " \033[0;32m+%s\033[0m \033[0;31m-%s\033[0m" "$added" "$removed"
  fi
fi

if [ -n "$model" ]; then
  printf " \033[0;36m[%s]\033[0m" "$model"
fi

if [ -n "$used_pct" ]; then
  printf " \033[0;35mctx:%s%%\033[0m" "$used_pct"
fi

printf "\n"
