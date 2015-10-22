#!/bin/sh

if test $(which brew)
then
  echo '  Installing dev environment...'
  brew install gpgme graphviz phantomjs icu4c

  mkdir -p $HOME/Library/LaunchAgents

  echo '  Installing atom editor'
  brew cask install atom

  echo '  Setup Postgres.app'
  brew cask install postgres
  brew cask install pgadmin3

  echo '  Setup mongodb'
  brew install mongodb
  ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

  echo '  Setup memcached'
  brew install memcached
  ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgent
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist

  echo '  Setup elasticsearch'
  brew install elasticsearch
  ln -sfv /usr/local/opt/elasticsearch14/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist

  echo '  Setup redis'
  brew install redis
  ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist

  echo '  Setup heroku'
  brew install heroku-toolbelt

  echo '  Install essential tools'
  # Install homebrew packages
  #brew install grc coreutils spark
  brew install coreutils htop ag

  echo '  Setup Android Studio'
  brew cask install android-studio
fi
