#!/bin/bash
source helpers

mkdir -p "$HOME/.config/karabiner/"
cp "$(current_dir)/karabiner.json.symlink" "$HOME/.config/karabiner/karabiner.json"
cp "$(current_dir)/assets/complex_modifications/"*.json "$HOME/.config/karabiner/assets/complex_modifications/"

exit 0
