#!/bin/sh

if test $(which brew)
then
  LOG="/tmp/install-vim.log"

  echo '  Installing and configuring VIM.'
  brew install vim > $LOG

  # Installing janus-vim
  curl -Lo- https://bit.ly/janus-bootstrap | bash >> $LOG

  # Installing additional plugins
  JANUS_EXTRAS=$HOME/.janus
  mkdir JANUS_EXTRAS

  git clone https://github.com/jistr/vim-nerdtree-tabs.git $JANUS_EXTRAS/vim-nerdtree-tabs >> $LOG
  git clone https://github.com/airblade/vim-gitgutter.git $JANUS_EXTRAS/vim-gitgutter >> $LOG
fi

exit 0
