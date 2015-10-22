#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

source print_helper

# Check for Homebrew
if test ! $(which brew); then
  info 'Installing Homebrew...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install brew cask to have apps out of the box
if test $(which brew); then
  info 'Installing brew-cask and GUI apps...'
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew install brew-cask

  while read app; do
    brew cask install $app
  done < "`pwd`/homebrew/apps"
  unset app
fi

exit 0
