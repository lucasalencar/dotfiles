# !/bin/sh
#
# Install zsh and oh-my-zsh

if test ! $(which ohmyzsh)
then
  echo "  Installing zsh and oh-my-zsh."
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh > /tmp/zsh-install.log

  # Install better zsh-completions
  git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
fi

exit 0
