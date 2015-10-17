#!/bin/sh
#
# Install essential softwares using homebrew

# Removes 'feature' that when pressing play on keyboard lauched iTunes
curl -o /tmp/PlayButtoniTunesPatch.zip http://www.thebitguru.com/site_media/uploads/downloads/PlayButtoniTunesPatch-0.8.3.zip
unzip -d /tmp /tmp/PlayButtoniTunesPatch.zip
sudo bash /tmp/PlayButtoniTunesPatch/Patch.command

exit 0
