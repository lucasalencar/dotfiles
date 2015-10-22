#!/bin/sh

source print_helper

if test $(which brew)
then
  info 'Installing and configuring VIM...'
  brew install vim

  # Installing janus-vim
  if [ ! -d "$HOME/.vim" ]
  then
    info 'Installing janus distribution...'
    curl -Lo- https://bit.ly/janus-bootstrap | bash

    # Installing additional plugins
    EXTRAS="$HOME/.janus"
    mkdir -p $EXTRAS

    git clone https://github.com/jistr/vim-nerdtree-tabs.git $EXTRAS/vim-nerdtree-tabs
    git clone https://github.com/airblade/vim-gitgutter.git $EXTRAS/vim-gitgutter
    git clone https://github.com/bling/vim-airline.git $EXTRAS/vim-airline
    git clone https://github.com/jiangmiao/auto-pairs.git $EXTRAS/auto-pairs

    # Add powerline fonts
    git clone https://github.com/powerline/fonts.git $EXTRAS/powerline-fonts
    bash $EXTRAS/powerline-fonts/install.sh
    rm -rf $EXTRAS/powerline-fonts

    # Add Smych theme
    git clone https://github.com/hukl/Smyck-Color-Scheme.git $EXTRAS/Smyck-Color-Scheme
    mkdir -p $EXTRAS/smyck/colors/
    cp $EXTRAS/Smyck-Color-Scheme/smyck.vim $EXTRAS/smyck/colors/smyck.vim
    rm -rf $EXTRAS/Smyck-Color-Scheme
  fi

  info 'Installing MacVIM and helpers...'
  brew cask install macvim seil
fi

exit 0
