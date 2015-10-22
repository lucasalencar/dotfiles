#!/bin/sh

source print_helper

if test ! $(which rbenv)
then
  LOG="/tmp/install-ruby.log"
  info "Installing rbenv..."
  brew install rbenv > $LOG
  brew install ruby-build >> $LOG

  info 'Installing latest ruby version...'
  rbenv install 2.2.2
  rbenv global 2.2.2

  info 'Installing bundler...'
  gem install bundler
fi

exit 0
