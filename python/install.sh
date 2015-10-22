#!/bin/sh

source print_helper

if test ! $(which pyenv)
then
  info "Installing pyenv..."
  brew install pyenv > /tmp/pyenv-install.log
fi

exit 0
