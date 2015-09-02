#!/bin/sh

echo "  Installing git latest version."
LOG="/tmp/install-git.log"
brew install git > $LOG
brew install hub >> $LOG

exit 0
