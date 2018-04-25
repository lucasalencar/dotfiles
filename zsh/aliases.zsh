# Override oh-my-zsh alias to a more user friendly
alias la='ls -lAh'

# Get OS X Software Updates, and update installed Ruby gem and Homebrew.
alias update="upgrade_oh_my_zsh; brew update; brew upgrade; brew cleanup; gem update --system; vim +PlugUpdate +PlugClean! +qall"

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
alias gupc="git pull --prune; gbda"

alias ds="docker-machine start; eval \$(docker-machine env)"
alias dss="docker-machine stop"

alias vi="vim"
alias iv="vim"

alias lr="lein repl"
