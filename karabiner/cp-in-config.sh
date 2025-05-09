#!/bin/bash

source "$DOTFILES_ROOT/helpers"

cp "$HOME/.config/karabiner/karabiner.json" "$(current_dir)/karabiner.json.symlink"

exit 0
