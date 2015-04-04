#!/bin/sh

if test $(which brew)
then
  LOG="/tmp/install-vim.log"

  echo '  Installing and configuring VIM.'
  brew install vim > $LOG

  # Installing janus-vim
  curl -Lo- https://bit.ly/janus-bootstrap | bash >> $LOG

  # Installing additional plugins
  mkdir $HOME/.janus
  git clone https://github.com/jistr/vim-nerdtree-tabs.git $HOME/.janus/vim-nerdtree-tabs >> $LOG
fi

exit 0
