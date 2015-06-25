#!/bin/sh

echo "  Installing newest git version."
brew install git > /tmp/git-install.log
brew install hub >> /tmp/git-install.log

exit 0
