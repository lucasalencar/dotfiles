#!/bin/bash

source "$DOTFILES_ROOT/print_helper"

# Script to initialize Git setup by configuring .gitconfig

# Source and destination files
GITCONFIG_SYMLINK="git/.gitconfig.example"
GITCONFIG_TARGET="git/.gitconfig"

# 1. Copy gitconfig file
if [ -f "$GITCONFIG_TARGET" ]; then
    user "WARNING: $GITCONFIG_TARGET already exists."
    read -p "Do you want to overwrite it? (y/N): " confirm_overwrite
    if [[ "$confirm_overwrite" != "y" && "$confirm_overwrite" != "Y" ]]; then
        info "gitconfig setup aborted."
        exit 0
    fi
fi

if [ -f "$GITCONFIG_SYMLINK" ]; then
    cp "$GITCONFIG_SYMLINK" "$GITCONFIG_TARGET"
    success "Copied $GITCONFIG_SYMLINK to $GITCONFIG_TARGET"
else
    fail "Error: $GITCONFIG_SYMLINK not found."
fi

# 2. Collect user information
info "Please enter your Git user information:"
read -p "Full Author Name: " git_user_name
read -p "Author Email: " git_user_email

# 3. Fill it with user information
# Using a temporary file for sed to work consistently across different OS (macOS vs Linux)
TMP_FILE=$(mktemp)

sed -e "s/AUTHOR NAME/$git_user_name/" -e "s/AUTHOR EMAIL/$git_user_email/" "$GITCONFIG_TARGET" > "$TMP_FILE" && mv "$TMP_FILE" "$GITCONFIG_TARGET"

if [ $? -eq 0 ]; then
    success "Successfully updated $GITCONFIG_TARGET with your information."
    success "Git configuration is set up."
else
    fail "Error updating $GITCONFIG_TARGET."
fi
