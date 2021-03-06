# Prefer homebrew installations
#export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Prefer nix installations
#export PATH=$HOME/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:$PATH

# Default editor
export EDITOR="nvim"

# Uses anaconda first for python
export PATH=/usr/local/anaconda3/bin:"$PATH"

# Add scripts to PATH
export PATH="$HOME/.dotfiles/scripts":"$PATH"

export LANG="en_US.UTF-8"

# emacs binaries
export PATH=$HOME/.emacs.d/bin:$PATH

export CODE_HOME="$HOME/code/"
