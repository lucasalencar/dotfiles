#!/bin/sh

if test ! $(which rbenv)
then
  echo "  Installing rbenv."
  brew install rbenv > /tmp/rbenv-install.log
  brew install ruby-build > /tmp/ruby-build-install.log
fi

exit 0
