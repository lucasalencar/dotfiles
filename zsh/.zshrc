# Path to Dotfiles root — exported before tmux so the tmux server (and any
# hook scripts it runs) inherit it.
export DOTFILES_ROOT=$HOME/.dotfiles

source $DOTFILES_ROOT/homebrew/rc

# Attach to tmux before anything else. `exec` replaces this shell, so the outer
# shell never pays the cost of sourcing rc / initializing pyenv/jenv/etc — the
# inner shell (inside tmux) is the one that matters. Must be above the p10k
# instant prompt block: tmux requires a real TTY.
#
# In case of terminal not opening, remove `exec` to see the underlying error
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
  exec tmux new-session -A -s main
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
