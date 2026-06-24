# User friedly ls
alias la='ls -lAh --color'
alias l='ls -lAh --color'
alias ls='ls --color'

# Update command - accepts package names as arguments
# Usage: update [package1] [package2] ... (updates all if no arguments)
update() {
  "$HOME/.dotfiles/update" "$@"
}

alias reload!='. ~/.zshrc'

# Aliases to config files
alias dotfiles='cd $HOME/.dotfiles; $EDITOR $HOME/.dotfiles/README.md'

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
alias vim="nvim"
alias t="tmux"

alias gs="gst"

gdls() {
  local base=$(git rev-parse --abbrev-ref origin/HEAD 2>/dev/null | sed 's|origin/||' || echo master)
  git diff --shortstat $(git merge-base HEAD $base)
}
