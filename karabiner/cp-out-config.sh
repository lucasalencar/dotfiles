#!/bin/bash
source "$DOTFILES_ROOT/helpers"

mkdir -p "$HOME/.config/karabiner/"
cp "$(current_dir)/karabiner.json.symlink" "$HOME/.config/karabiner/karabiner.json"

exit 0
