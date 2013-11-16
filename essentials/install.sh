#!/bin/sh
#
# Install essential softwares using homebrew

# read & write NTFS permission
# Based on:
# http://crosstown.coolestguidesontheplanet.com/os-x/44-how-to-write-to-a-ntfs-drive-from-os-x
if test ! $(which ntfs-3g)
then
	echo "	Installing ntfs-3g for you!"
  brew install fuse4x ntfs-3g
  sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.orig
  sudo ln -s /usr/local/Cellar/ntfs-3g/2013.1.13/sbin/mount_ntfs /sbin/mount_ntfs
  sudo cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.2/Library/Extensions/fuse4x.kext /Library/Extensions
  sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x
fi

exit 0
