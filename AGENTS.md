# Lucas Alencar Dotfiles

## Profiles

Flat profiles, one per machine, with no dependencies between them:

- `mac-personal`: Personal MacBook (full desktop environment).
- `mac-work`: Work MacBook (Nubank).
- `homelab`: Headless Ubuntu Linux server (shell + tmux + vim).

## Preferred Package Manager

Homebrew, on both macOS and Linux (Linuxbrew). Declare dependencies with
`brew install` in the owning package's `install` script — one declaration
covers both OSes. The only `Brewfile` is `mac-apps/Brewfile` (desktop
casks). Use `apt` only for pre-brew bootstrap or when a formula has no
Linux bottle (then use the upstream installer on Linux). If no package
owns a new dependency, create one and list it in the profiles that need it.

## Cross-platform rules (macOS + Ubuntu Linux)

- Every package script (`install`, `setup`, `update`) must run on both
    macOS and Linux. Never hardcode OS-specific paths (`/opt/homebrew`,
    `/Users/...`); resolve them at runtime (`ensure_brew_env`, `$HOME`).
- OS-specific work belongs behind a guard. `require_macos "<label>"`
    (from `helpers`) exits the script successfully on other OSes — safe
    because package scripts run as child processes of `./install`. Use
    `is_macos` / `is_linux` for inline branches (e.g. different install
    commands per OS).
- Casks and `defaults write` are macOS-only — never bare
    `brew install --cask` in a shared script without `require_macos`.
- Desktop notifications and GUI helpers must degrade gracefully: they
    exit 0 on headless Linux so agent hooks and tmux integrations keep
    working without a desktop.

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
    `effortLevel` or `model` fields, or to Codex's configuration file
    (`codex/.codex/config.toml`) when they only touch the `model` or
    `model_reasoning_effort` fields — these are routine day-to-day tweaks that
    don't need to be committed. Other changes to those files (hooks,
    permissions, etc.) should still be committed normally.
