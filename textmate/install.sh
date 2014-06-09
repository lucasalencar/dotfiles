#!/bin/sh

echo '  Installing TextMate2.'
brew cask install textmate2 > /tmp/install-textmate2.log

BUNDLES="~/Library/Application Support/TextMate/Managed/Bundles"

mkdir -p $BUNDLES

git clone https://github.com/elia/avian-missing.tmbundle.git $BUNDLES/avian-missing.tmbundle
git clone https://github.com/textmate/monokai.tmbundle.git $BUNDLES/Monokai.tmbundle
git clone https://github.com/textmate/latex.tmbundle.git $BUNLDES/LaTeX.tmbundle

exit 0
