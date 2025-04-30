#!/bin/bash

source helpers

if [[ "$OSTYPE" == "darwin"* ]]; then
    info "Setting up key repeat for VS Code on macOS..."

    export CURSOR_ID=$(osascript -e 'id of app "Cursor"')
    defaults write $CURSOR_ID ApplePressAndHoldEnabled -bool false
fi

stow cursor
