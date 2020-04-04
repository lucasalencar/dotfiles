#!/bin/bash
source helpers

current_dir # Sets $CURRENT_DIR variable
cp "$HOME/.config/karabiner/karabiner.json" "$CURRENT_DIR/karabiner.json.symlink"

exit 0
