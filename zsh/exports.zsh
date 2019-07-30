# Prefer homebrew installations
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Add Go Paths
#export GOPATH=$HOME/code/go
#export PATH=$PATH:$GOPATH/bin

# Default editor
export EDITOR="nvim"

# But if I am using emacs, use emacs to edit
if [[ -n "${EMACS}" ]]; then
  export VISUAL="emacsclient"
  export EDITOR="${VISUAL}"
  export GIT_EDITOR="${EDITOR}"
  # Disable RPROMPT in Emacs term
  export RPROMPT=""
fi

# Uses anaconda first for python
export PATH=$HOME/.dotfiles/scripts:/usr/local/anaconda3/bin:"$PATH"

export LANG="en_US.UTF-8"

# emacs binaries
export PATH=$HOME/.emacs.d/bin:$PATH

export CODE_HOME="$HOME/code/"
