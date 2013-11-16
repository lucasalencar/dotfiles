# Override oh-my-zsh alias to a more user friendly
alias la='ls -lAh'

# Get OS X Software Updates, and update installed Ruby gem and Homebrew.
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; sudo gem update'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias reload!='. ~/.zshrc'

alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
