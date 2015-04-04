# Override oh-my-zsh alias to a more user friendly
alias la='ls -lAh'

# Get OS X Software Updates, and update installed Ruby gem and Homebrew.
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; sudo gem update'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias reload!='. ~/.zshrc'

# Aliases to config files
alias zshconfig="mvim ~/.zshrc"
alias ohmyzsh="mvim ~/.oh-my-zsh"
alias dotfiles="mvim ~/.dotfiles"

# Alert when internet is back
alias wtfimi="until ping -W1 -c1 google.com; do sleep 5; done && say the internet is fucking back"

# Organizing photos from camera
alias photos="mkdir jpg raw; mv *.JPG jpg/; mv *.CR2 raw/"

alias mklatex="latexmk -quiet -pv -pdf -pdflatex=\"pdflatex --shell-escape %O %S\""
