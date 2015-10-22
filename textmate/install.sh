#!/bin/sh

source print_helper

if test $(which brew)
then
  info 'Installing TextMate2...'
  brew cask install textmate2

  BUNDLES="/Users/$USER/Library/Application Support/TextMate/Managed/Bundles"
  mkdir -p $BUNDLES

  echo > /tmp/tm2-bundle-install.log
  git clone https://github.com/elia/avian-missing.tmbundle.git "$BUNDLES/avian-missing.tmbundle"
  git clone https://github.com/textmate/monokai.tmbundle.git "$BUNDLES/Monokai.tmbundle"
  git clone https://github.com/textmate/latex.tmbundle.git "$BUNLDES/LaTeX.tmbundle"
  git clone https://github.com/textmate/source.tmbundle.git "$BUNLDES/Source.tmbundle"
fi

exit 0
