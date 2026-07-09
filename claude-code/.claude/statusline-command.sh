#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input"    | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input"  | jq -r '.model.display_name // empty')

# Tenta ler effortLevel do settings.json do projeto ou global
project_settings="$cwd/.claude/settings.json"
if [ -f "$project_settings" ]; then
  effort=$(jq -r '.effortLevel // empty' "$project_settings" 2>/dev/null)
else
  effort=$(jq -r '.effortLevel // empty' ~/.claude/settings.json 2>/dev/null)
fi
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
  cache_key=$(printf "%s:%s" "$cwd" "$git_branch" | shasum | cut -c1-16)
  cache_file="/tmp/claude-statusline-pr-${cache_key}"
  cache_ttl=300
  cache_valid=false
  if [ -f "$cache_file" ]; then
    mtime=$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null)
    [ $(( $(date +%s) - ${mtime:-0} )) -lt $cache_ttl ] && cache_valid=true
  fi
  if $cache_valid; then
    pr_url=$(cat "$cache_file")
  else
    pr_url=$(cd "$cwd" && timeout 3 gh pr view --json url -q .url 2>/dev/null)
    echo "$pr_url" > "$cache_file"
  fi
  [ -n "$pr_url" ] && printf " ${DIM}%s${RESET}" "$pr_url"
fi
printf "\n"

# --- Line 2: model | context bar | cost ---
if   [ "$pct" -ge 80 ]; then bar_color="$RED"
elif [ "$pct" -ge 51 ]; then bar_color="$YELLOW"
else bar_color="$GREEN"; fi

filled=$((pct / 10)); empty=$((10 - filled))
printf -v bar "%${filled}s"; printf -v pad "%${empty}s"
bar="${bar// /█}${pad// /░}"

model_display="$model"
[ -n "$effort" ] && model_display="$model_display ($effort)"
printf " ${CYAN}✦ %s${RESET}" "$model_display"
printf " ${DIM}|${RESET} ${bar_color}[%s] %s%%${RESET}" "$bar" "$pct"
[ -n "$cost" ] && printf " ${DIM}|${RESET} ${YELLOW}\$%.4f${RESET}" "$cost"
printf "\n"
