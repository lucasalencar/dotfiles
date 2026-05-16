#!/bin/bash

source "$DOTFILES_ROOT/print_helper"

# Git config template and generated files
GITCONFIG_SYMLINK="git/.gitconfig.example"
GITCONFIG_TARGET="git/.gitconfig"
HOME_GITCONFIG="$HOME/.gitconfig"

# Detect OS and set appropriate credential helper
OS="$(uname -s)"
case "$OS" in
    Darwin)
        CREDENTIAL_HELPER="osxkeychain"
        ;;
    Linux)
        CREDENTIAL_HELPER="cache"
        ;;
    *)
        CREDENTIAL_HELPER="cache"
        ;;
esac

# Confirm before continuing if a home git config already exists
if [ -f "$HOME_GITCONFIG" ]; then
    user "WARNING: $HOME_GITCONFIG already exists."
    read -p "Do you want to continue with this git config setup? (y/N): " confirm_continue
    if [[ "$confirm_continue" != "y" && "$confirm_continue" != "Y" ]]; then
        info "gitconfig setup aborted."
        exit 0
    fi
fi

# Confirm before replacing the generated git config
if [ -f "$GITCONFIG_TARGET" ]; then
    user "WARNING: $GITCONFIG_TARGET already exists."
    read -p "Do you want to overwrite it? (y/N): " confirm_overwrite
    if [[ "$confirm_overwrite" != "y" && "$confirm_overwrite" != "Y" ]]; then
        info "gitconfig setup aborted."
        exit 0
    fi
fi

# Copy the template that will be filled with user information
if [ -f "$GITCONFIG_SYMLINK" ]; then
    cp "$GITCONFIG_SYMLINK" "$GITCONFIG_TARGET"
    success "Copied $GITCONFIG_SYMLINK to $GITCONFIG_TARGET"
else
    fail "Error: $GITCONFIG_SYMLINK not found."
fi

info "Please enter your Git user information:"
read -p "Full Author Name: " git_user_name
read -p "Author Email: " git_user_email

# Fill placeholders using a temporary file for macOS/Linux sed compatibility
TMP_FILE=$(mktemp)

sed -e "s/AUTHOR NAME/$git_user_name/" -e "s/AUTHOR EMAIL/$git_user_email/" -e "s/CREDENTIAL HELPER/$CREDENTIAL_HELPER/" "$GITCONFIG_TARGET" > "$TMP_FILE" && mv "$TMP_FILE" "$GITCONFIG_TARGET"

if [ $? -eq 0 ]; then
    success "Successfully updated $GITCONFIG_TARGET with your information."
    success "Git configuration is set up."
else
    fail "Error updating $GITCONFIG_TARGET."
fi
