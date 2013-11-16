# !/bin/sh
# 
# Install zsh and oh-my-zsh

if test ! $(which zsh)
then
  echo "  Installing zsh and oh-my-zsh."
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

exit 0
