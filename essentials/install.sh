#!/bin/sh
#
# Install essential softwares using homebrew

# Removes 'feature' that when pressing play on keyboard lauched iTunes
curl -o /tmp/PlayButtoniTunesPatch.zip http://www.thebitguru.com/site_media/uploads/downloads/PlayButtoniTunesPatch-0.8.3.zip
unzip -d /tmp /tmp/PlayButtoniTunesPatch.zip
sudo bash /tmp/PlayButtoniTunesPatch/Patch.command

# Installing Smyck color scheme
git clone https://github.com/hukl/Smyck-Color-Scheme.git /tmp/smyck
open /tmp/smyck/Smyck.terminal

# Copy smyck vim theme to janus
mkdir -p ~/.janus/vim/colors/smyck/colors/
cp /tmp/smyck/smyck.vim ~/.janus/vim/colors/smyck/colors/smyck.vim

exit 0
