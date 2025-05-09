#!/bin/bash

# Script to initialize Git setup by configuring .gitconfig

# Determine the directory where the script is located
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# Assume the script is in a subdirectory of the dotfiles root (e.g., dotfile_scripts)
# and the 'git' directory is at the root.
DOTFILES_ROOT="$SCRIPT_DIR/.."

# Source and destination files
GITCONFIG_SYMLINK="$DOTFILES_ROOT/git/.gitconfig.example"
GITCONFIG_TARGET="$DOTFILES_ROOT/git/.gitconfig"

# 1. Copy gitconfig file
if [ -f "$GITCONFIG_TARGET" ]; then
    echo "WARNING: $GITCONFIG_TARGET already exists."
    read -p "Do you want to overwrite it? (y/N): " confirm_overwrite
    if [[ "$confirm_overwrite" != "y" && "$confirm_overwrite" != "Y" ]]; then
        echo "gitconfig setup aborted."
        exit 0
    fi
fi

if [ -f "$GITCONFIG_SYMLINK" ]; then
    cp "$GITCONFIG_SYMLINK" "$GITCONFIG_TARGET"
    echo "Copied $GITCONFIG_SYMLINK to $GITCONFIG_TARGET"
else
    echo "Error: $GITCONFIG_SYMLINK not found."
    exit 1
fi

# 2. Collect user information
echo "Please enter your Git user information:"
read -p "Full Author Name: " git_user_name
read -p "Author Email: " git_user_email

# 3. Fill it with user information
# Using a temporary file for sed to work consistently across different OS (macOS vs Linux)
TMP_FILE=$(mktemp)

sed -e "s/AUTHOR NAME/$git_user_name/" -e "s/AUTHOR EMAIL/$git_user_email/" "$GITCONFIG_TARGET" > "$TMP_FILE" && mv "$TMP_FILE" "$GITCONFIG_TARGET"

if [ $? -eq 0 ]; then
    echo "Successfully updated $GITCONFIG_TARGET with your information."
    echo "Git configuration is set up."
else
    echo "Error updating $GITCONFIG_TARGET."
    exit 1
fi
