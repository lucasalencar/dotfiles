# Prefer nix installations
#export PATH=$HOME/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:$PATH

# Default editor
export EDITOR="nvim"

export LANG="en_US.UTF-8"

# Respect an existing CODE_HOME if already set (e.g., by the launching shell)
export CODE_HOME="${CODE_HOME:-$HOME/code/}"

# Unversioned secrets (never commit): sourced before any tmux server starts,
# so servers inherit them for config resolution.
[ -f ~/.config/tama/remote.env ] && . ~/.config/tama/remote.env
