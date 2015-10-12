#!/usr/bin/env bash
#
# Installation process

link_files () {
  ln -sf $1 $2
  echo "Linked $1 to $2"
}

DOTFILES_ROOT="`pwd`"

# Install some essential softwares
packages=(homebrew git zsh ruby python vim dev osx essentials)
for package in "${packages[@]}"; do
  echo "  Setting up $package package..."
  $DOTFILES_ROOT/$package/install.sh

  # Link config files
  for source in `find $DOTFILES_ROOT/$package -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"
    link_files $source $dest
  done
done
unset file

exit 0
