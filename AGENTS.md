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
- Commit and push only when asked.
- It's fine to commit and push directly to `master` in this repo — that's
    the normal workflow here. No need to ask about creating a branch first.
- All code, comments, and documentation must be written in English.
- During commits, ignore changes to Claude's `settings.json` configuration
    file (e.g., `claude-code/.claude/settings.json`) when they only touch the
    `effortLevel` or `model` fields — these are routine day-to-day tweaks that
    don't need to be committed. Other changes to that file (hooks, permissions,
    etc.) should still be committed normally.
