# Override oh-my-zsh alias to a more user friendly
alias la='ls -lAh'

# Specific update aliases
alias update_zsh="$HOME/.dotfiles/zsh/update"
alias update_brew="$HOME/.dotfiles/homebrew/update"
alias update_nvim="$HOME/.dotfiles/nvim/update"
alias update_tmux="$HOME/.dotfiles/tmux/update"
alias update_emacs="$HOME/.dotfiles/emacs/update"
alias update_nix="$HOME/.dotfiles/nix/update"

# Update every system that is interesting for the command line
alias update="$HOME/.dotfiles/update"

alias reload!='. ~/.zshrc'

# Aliases to config files
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias dotfiles="cd $HOME/.dotfiles; $EDITOR $HOME/.dotfiles"

# Use colordiff as default diff command
# y => shows diffs in 2 columns
# b => ignores white spaces
# B => ignores blank lines
alias diff="colordiff -ybB"

# Git pull and many other flags
alias gupc="git pull --prune --rebase; gbda"

# Reuse previous message that was resetted
alias greuse="git commit --reuse-message=HEAD@{1}"

# Use git log given a limited number of commits
alias glon="git log --oneline --decorate -n"

alias ds="docker-machine start; eval \$(docker-machine env)"
alias dss="docker-machine stop"

alias vi="nvim"
alias iv="nvim"
alias v="nvim"
alias t="tmux"

alias lr="lein repl"
alias l="lein"
alias lnt="lein nu-test"

alias gs="gst"
alias gdst="git diff --stat master HEAD" # Show number of lines changed for current branch
