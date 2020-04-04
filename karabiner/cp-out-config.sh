#!/bin/bash
source helpers

current_dir # Sets $CURRENT_DIR variable
mkdir -p "$HOME/.config/karabiner/"
cp "$CURRENT_DIR/karabiner.json.symlink" "$HOME/.config/karabiner/karabiner.json"

exit 0
