# Prefer homebrew installations
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Command lines tools from Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

# Adds to path automation scripts
export PATH=$PATH:$DOTFILES_ROOT/automations

# Add Go Paths
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

# Default editor
export EDITOR="mvim"

# Uses anaconda first for python
export PATH=$HOME/anaconda3/bin:"$PATH"
