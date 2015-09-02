#!/bin/sh

if test $(which brew)
then
  LOG="/tmp/install-vim.log"

  echo '  Installing and configuring VIM.'
  brew install vim > $LOG

  # Installing janus-vim
  curl -Lo- https://bit.ly/janus-bootstrap | bash >> $LOG

  # Installing additional plugins
  EXTRAS="$HOME/.janus"
  mkdir EXTRAS

  git clone https://github.com/jistr/vim-nerdtree-tabs.git $EXTRAS/vim-nerdtree-tabs >> $LOG
  git clone https://github.com/airblade/vim-gitgutter.git $EXTRAS/vim-gitgutter >> $LOG
  git clone https://github.com/bling/vim-airline.git $EXTRAS/vim-airline >> $LOG

  git clone https://github.com/powerline/fonts.git $EXTRAS/powerline-fonts >> $LOG
  bash $EXTRAS/powerline-fonts/install.sh
  rm -rf $EXTRAS/powerline-fonts
fi

exit 0
