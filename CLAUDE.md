# Lucas Alencar Dotfiles

## Profiles

The dotfiles are organized into different profiles:

- `basic`: Essential packages and configurations that I use on all
    machines.
- `personal`: Personal development environment with additional tools for
    my personal machine.
- `nubank`: My work environment setup with specific tools and
    configurations for my job at Nubank.

## Rules

- Maintain package list from README.md updated with the newly or removed
    packages.
- When creating or modifying configuration files for any tool, prefer
    placing them inside this dotfiles repo instead of directly in local
    config folders (e.g. `~/.config/`, `~/.claude/`, `~/.local/`, etc.).
    Files here should be symlinked to their expected locations via stow.
    Before creating a config file, check if a package for that tool already
    exists in this repo. If it does not, ask whether to create one before
    proceeding.
- It's fine to commit and push directly to `master` in this repo — that's
    the normal workflow here. No need to ask about creating a branch first.
