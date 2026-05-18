# Path to Dotfiles root — exported before tmux so the tmux server (and any
# hook scripts it runs) inherit it.
export DOTFILES_ROOT=$HOME/.dotfiles

source $DOTFILES_ROOT/homebrew/rc

# Auto-attach tmux only when appropriate. `exec` replaces this shell, so the
# outer shell never pays the cost of sourcing rc — the inner shell (inside
# tmux) is the one that matters. Must be above the p10k instant prompt block:
# tmux requires a real TTY.
#
# Logic:
#   1. No "main" session → create and attach
#   2. "main" session exists but no client attached → attach
#   3. "main" session exists with clients attached → do nothing (plain shell)
#
# In case of terminal not opening, remove `exec` to see the underlying error
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
  if tmux has-session -t main 2>/dev/null; then
    if [[ -z "$(tmux list-clients -t main 2>/dev/null)" ]]; then
      exec tmux attach-session -t main
    fi
  else
    exec tmux new-session -s main
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
