# !/bin/sh
#
# Install zsh and oh-my-zsh

source print_helper

if test ! $(which zsh)
then
  info "Installing zsh and oh-my-zsh..."
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

  # Install better zsh-completions
  git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
fi

exit 0
