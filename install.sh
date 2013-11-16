#!/usr/bin/env bash
# 
# Installation process

link_files () {
  ln -sf $1 $2
  echo "Linked $1 to $2"
}

DOTFILES_ROOT="`pwd`"

# Install some essential softwares
for file in $DOTFILES_ROOT/{homebrew,essentials,zsh}/install.sh; do
  $file
done
unset file

# Link config files
for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
do
  dest="$HOME/.`basename \"${source%.*}\"`"
  link_files $source $dest
done
