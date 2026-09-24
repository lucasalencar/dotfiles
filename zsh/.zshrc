# Path to Dotfiles root — exported before tmux so the tmux server (and any
# hook scripts it runs) inherit it.
export DOTFILES_ROOT=$HOME/.dotfiles

source $DOTFILES_ROOT/homebrew/rc

# Fall back to a widely-supported TERM when the current one has no
# terminfo entry on this machine (e.g. xterm-ghostty over SSH without
# ghostty terminfo installed). tmux and other curses apps fail otherwise.
if command -v infocmp >/dev/null 2>&1 && [ -n "${TERM:-}" ]; then
  infocmp "$TERM" >/dev/null 2>&1 || export TERM=xterm-256color
fi

# Default tmux session follows the active machine profile (e.g. "mac-personal",
# "mac-work", "homelab"), so the session name identifies the machine.
# Set TMUX_DEFAULT_SESSION to override.
if [ -z "${TMUX_DEFAULT_SESSION:-}" ]; then
  _dotfiles_profile=$(head -n 1 "$DOTFILES_ROOT/.current_profile" 2>/dev/null | tr -d '[:space:]' | tr '.:' '__')
  TMUX_DEFAULT_SESSION="${_dotfiles_profile:-main}"
  unset _dotfiles_profile
fi

# Auto-attach tmux only when appropriate. On success the outer shell exits
# right after attach/detach, so it never pays the cost of sourcing rc — the
# inner shell (inside tmux) is the one that matters. On failure (missing or
# broken tmux, unreadable terminal, ...) it falls through to a plain shell
# instead of killing the session. Must be above the p10k instant prompt
# block: tmux requires a real TTY.
#
# Logic:
#   1. No session → create and attach
#   2. Session exists but no client attached → attach
#   3. Session exists with clients attached → do nothing (plain shell)
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && command -v tmux >/dev/null 2>&1; then
  if tmux has-session -t "$TMUX_DEFAULT_SESSION" 2>/dev/null; then
    if [[ -z "$(tmux list-clients -t "$TMUX_DEFAULT_SESSION" 2>/dev/null)" ]]; then
      tmux attach-session -t "$TMUX_DEFAULT_SESSION" && exit
    fi
  else
    tmux new-session -s "$TMUX_DEFAULT_SESSION" -c "$HOME" && exit
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $DOTFILES_ROOT/rc

# Use FZF as fuzzy search inside terminal (ctrl+r)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
