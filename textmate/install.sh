#!/bin/sh

if test $(which brew)
then
  echo '  Installing TextMate2.'
  brew cask install textmate2 > /tmp/install-textmate2.log

  BUNDLES="/Users/$USER/Library/Application Support/TextMate/Managed/Bundles"
  mkdir -p $BUNDLES

  echo > /tmp/tm2-bundle-install.log
  git clone https://github.com/elia/avian-missing.tmbundle.git "$BUNDLES/avian-missing.tmbundle" >> /tmp/tm2-bundle-install.log
  git clone https://github.com/textmate/monokai.tmbundle.git "$BUNDLES/Monokai.tmbundle" >> /tmp/tm2-bundle-install.log
  git clone https://github.com/textmate/latex.tmbundle.git "$BUNLDES/LaTeX.tmbundle" >> /tmp/tm2-bundle-install.log
  git clone https://github.com/textmate/source.tmbundle.git "$BUNLDES/Source.tmbundle" >> /tmp/tm2-bundle-install.log
fi

exit 0
