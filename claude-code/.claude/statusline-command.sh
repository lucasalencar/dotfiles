#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input"    | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input"  | jq -r '.model.display_name // empty')
pct=$(echo "$input"    | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
cost=$(echo "$input"   | jq -r '.cost.total_cost_usd // empty')

CYAN='\033[36m'; YELLOW='\033[33m'; GREEN='\033[32m'; RED='\033[31m'
DIM='\033[2;37m'; RESET='\033[0m'

# --- Line 1: dir + git branch + diff stats ---
short_dir="${cwd/#$HOME/\~}"
printf " ${RESET}%s${RESET}" "$short_dir"

git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$git_branch" ]; then
  printf " ${YELLOW}(%s)${RESET}" "$git_branch"
  diff_stats=$(git -C "$cwd" --no-optional-locks diff HEAD --shortstat 2>/dev/null)
  added=$(echo "$diff_stats"   | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
  removed=$(echo "$diff_stats" | grep -oE '[0-9]+ deletion'  | grep -oE '[0-9]+')
  [ -n "$added" ] || [ -n "$removed" ] && \
    printf " ${GREEN}+%s${RESET} ${RED}-%s${RESET}" "${added:-0}" "${removed:-0}"
fi
printf "\n"

# --- Line 2: model | context bar | cost ---
if   [ "$pct" -ge 80 ]; then bar_color="$RED"
elif [ "$pct" -ge 51 ]; then bar_color="$YELLOW"
else bar_color="$GREEN"; fi

filled=$((pct / 10)); empty=$((10 - filled))
printf -v bar "%${filled}s"; printf -v pad "%${empty}s"
bar="${bar// /█}${pad// /░}"

printf " ${CYAN}✦ %s${RESET}" "$model"
printf " ${DIM}|${RESET} ${bar_color}[%s] %s%%${RESET}" "$bar" "$pct"
[ -n "$cost" ] && printf " ${DIM}|${RESET} ${YELLOW}\$%.4f${RESET}" "$cost"
printf "\n"
