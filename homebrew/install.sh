#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew."
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" > /tmp/homebrew-install.log
fi

# Install homebrew packages
# brew install grc coreutils spark

# Install brew cask to have apps out of the box
if test $(which brew) then
  echo "  Installing brew cask and apps."
  brew tap caskroom/cask > /tmp/tap-cask.log
  brew tap caskroom/versions > /tmp/tap-cask-versions.log
  brew install brew-cask > /tmp/brew-cask-install.log

  while read app; do
    brew cask install $app
  done < apps
  unset app
fi

exit 0
