#!/bin/sh

if test ! $(which rbenv)
then
  LOG="/tmp/install-ruby.log"
  echo "  Installing rbenv."
  brew install rbenv > $LOG
  brew install ruby-build >> $LOG

  echo '  Installing latest ruby version.'
  rbenv install 2.2.2
  rbenv global 2.2.2
fi

exit 0
