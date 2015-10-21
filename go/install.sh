#!/bin/bash

if test ! $(which go)
then
  brew install go
  mkdir -p $HOME/code/go
fi

