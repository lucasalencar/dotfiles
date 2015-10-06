#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

LOG="/tmp/install-homebrew.log"

# Check for Homebrew
if test ! $(which brew); then
  echo "  Installing Homebrew."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > $LOG
fi

# Install homebrew packages
#brew install grc coreutils spark
brew install coreutils ag

# Install brew cask to have apps out of the box
if test $(which brew); then
  echo "  Installing brew-cask and GUI apps."
  brew tap caskroom/cask >> $LOG
  brew tap caskroom/versions >> $LOG
  brew install brew-cask >> $LOG

  while read app; do
    brew cask install $app
  done < "`pwd`/homebrew/apps"
  unset app
fi

exit 0
