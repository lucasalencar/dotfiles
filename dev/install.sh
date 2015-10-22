#!/bin/sh

source print_helper

if test $(which brew)
then
  info 'Installing dev environment...'
  brew install gpgme graphviz phantomjs icu4c

  mkdir -p $HOME/Library/LaunchAgents

  info 'Installing Atom'
  brew cask install atom

  info 'Setup Postgres.app'
  brew cask install postgres
  brew cask install pgadmin3

  info 'Setup mongodb'
  brew install mongodb
  ln -sfv /usr/local/opt/mongodb/*.plist $HOME/Library/LaunchAgents
  launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

  info 'Setup memcached'
  brew install memcached
  ln -sfv /usr/local/opt/memcached/*.plist $HOME/Library/LaunchAgent
  launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.memcached.plist

  info 'Setup elasticsearch'
  brew install elasticsearch
  ln -sfv /usr/local/opt/elasticsearch14/*.plist $HOME/Library/LaunchAgents
  launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist

  info 'Setup redis'
  brew install redis
  ln -sfv /usr/local/opt/redis/*.plist $HOME/Library/LaunchAgents
  launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.redis.plist

  info 'Setup heroku'
  brew install heroku-toolbelt

  info 'Install essential tools'
  brew install coreutils htop ag

  info 'Setup Android Studio'
  brew cask install android-studio
fi

exit 0
