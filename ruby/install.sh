#!/bin/sh

source print_helper

if test ! $(which rbenv)
then
  info "Installing rbenv..."
  brew install rbenv
  brew install ruby-build

  info 'Installing latest ruby version...'
  rbenv install 2.2.2
  rbenv global 2.2.2

  info 'Installing bundler...'
  gem install bundler
fi

exit 0
