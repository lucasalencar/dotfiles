#!/bin/sh

if test ! $(which rbenv)
then
  LOG="/tmp/install-ruby.log"
  echo "  Installing rbenv."
  brew install rbenv > $LOG
  brew install ruby-build >> $LOG
fi

exit 0
