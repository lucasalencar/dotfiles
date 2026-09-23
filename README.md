# Dotfiles

Personal machine setup. Centralized configuration for shell, editors, version
managers and CLI tooling, organized by **profile** (one per machine) so the
same repository can bootstrap a MacBook or a headless Linux server.

## How it works

The repository is organized as a collection of **packages** (one per top-level
directory: `git/`, `zsh/`, `vim/`, `homebrew/`, ...) and **profiles**
(`profiles/mac-personal`, `profiles/mac-work`, `profiles/homelab`).

A profile is just a plain-text list of package names — one per machine, with
no dependencies between profiles. Running `./install <profile>` will, for
each package in that profile:

1. Run its `install` script (if present) — installs binaries / clones plugins.
2. Run its `setup` script (if present) — symlinks dotfiles into `$HOME`.
3. Source its `rc` file (if present) on every new shell, via the top-level
   `rc` loader.

Each package owns its own dependencies in its `install` script (Homebrew
formulae on macOS and Linux, `apt` for Linux-only bootstrap, official
installers where Homebrew has no bottle). The only exception is `mac-apps/`,
which keeps a per-package `Brewfile` for its long list of desktop casks.

## Available profiles

| Profile        | Use case                                              |
| -------------- | ----------------------------------------------------- |
| `mac-personal` | Personal MacBook (full desktop environment).          |
| `mac-work`     | Work MacBook (Nubank).                                |
| `homelab`      | Headless Linux server (Ubuntu): shell + tmux + vim.   |

## Setup

### Prerequisites

- macOS or Ubuntu Linux.
- Git installed and available on `PATH`.
- On Ubuntu: `sudo` access (to install base tools and Homebrew build deps).
- Homebrew is installed automatically if missing (Linuxbrew on Linux).

### 1. Clone

```bash
git clone https://github.com/lucasalencar/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Install

> ⚠️ **Warning:** the install will create symlinks in `$HOME` and may
> overwrite existing dotfiles (`~/.zshrc`, `~/.gitconfig`, `~/.tmux.conf`,
> ...). Back up anything you want to keep first.

Pick the profile that matches the machine:

```bash
./install mac-personal  # personal MacBook
./install mac-work      # work MacBook
./install homelab       # headless Linux server
```

What `./install` does, in order:

1. On Linux, bootstraps base tools first: the initial packages (`git`,
   `zsh`) apt-provide their own binaries when Homebrew is not
   present yet.
2. Initializes `~/.gitconfig` from `git/.gitconfig.example`, prompting for
   your Git author name and email (`git/pre-setup`).
3. Installs Homebrew if missing (`homebrew/install`).
4. Installs/sets up each package listed in the profile, and stores its
   name in `.current_profile` so `rc` knows which profile to load on shell
   startup.

### 3. Reload your shell

Open a new terminal (or `source ~/.zshrc`) so the new dotfiles take effect.

### Claude Code settings

The versioned `claude-code/.claude/settings.json` is a sanitized base template,
not a symlink target. The Claude Code setup copies it to
`~/.claude/settings.json` only when that local file does not already exist.
Machine-specific authentication, endpoints, models, work plugins and MCP
servers should be configured only in the local files so they are not written
back to the repo.

## Updating

```bash
./update                 # pull repo + update everything for the active profile
./update <package> ...   # update only the listed package(s)
```

With no arguments, `./update` will:

1. `git pull --rebase` the dotfiles repo.
2. Update Homebrew packages (`brew update/upgrade/cleanup`, plus cask
   upgrades on macOS).
3. Re-run per-package `update` scripts for the profile recorded in
   `.current_profile`.

## Installing or updating a single package

Each package directory is self-contained. You can run its scripts directly
without going through the top-level `install`:

```bash
./git/install        # set up Git
./homebrew/install   # install/refresh Homebrew itself
./zsh/install        # ZSH config
./vim/install        # Vim config
./nvim/install       # Neovim config
./tmux/install       # Tmux config
```

Most packages also expose a matching `setup` (symlinks) and/or `update` script
that follows the same convention.

## Adding new packages

Add the install logic to the owning package's `install` script (a
`brew install` line, or a guarded block for OS-specific tools). If no
existing package is a natural owner, create a new one (like `doc-tools/`)
with its own `install` script and list it in the profiles
that need it. The only per-package `Brewfile` is `mac-apps/Brewfile`,
which uses Ruby `if OS.mac?` / `ENV['DOTFILES_PROFILE']` guards.

## Available packages

Each item below maps to a top-level directory in this repo. Most are wired up
through one of the profiles; `nix` is optional and only used when explicitly
invoked.

### Shell & terminal

| Package        | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| `zsh`          | ZSH shell config, plugins and prompt.                          |
| `tmux`         | Tmux config, plugins and key bindings.                         |
| `cli`          | Essential CLI tools (fzf, ripgrep, fd, jq, bat, ...).          |
| `gnu`          | GNU userland for macOS (native on Linux, skipped there).       |
| `doc-tools`    | Markdown/diagram toolchain (pandoc, plantuml, mermaid).        |
| `mac-apps`     | Desktop apps and fonts via per-package Brewfile (macOS only). |
| `ghostty`      | Ghostty terminal emulator config.                              |
| `kitty`        | Kitty terminal emulator config.                                |
| `scripts`      | Personal CLI helpers (`fgb`, `vf`, `notify-macos`, `agent-notify`, `speech-to-text`, ...). |

### Editors & IDEs

| Package        | Description                                              |
| -------------- | -------------------------------------------------------- |
| `vim`          | Vim config and plugins.                                  |
| `nvim`         | Neovim config (Lua-based setup).                         |
| `emacs`        | Emacs config.                                            |
| `cursor`       | Cursor editor settings, keybindings and rules.           |
| `logseq`       | Logseq knowledge-base config and themes.                 |

### AI / coding agents

| Package      | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| `claude-code`| Claude Code base settings, custom commands, hooks and MCPs. |
| `codex`      | Codex CLI configuration, hooks, notifications, and MCPs.     |
| `gemini`     | Gemini CLI configuration.                                    |
| `opencode`   | OpenCode agent configuration.                                |
| `prompts`    | Reusable prompt snippets shared across tools.                |
| `skills`     | AI coding agent skills (cloned from `~/code/skills`).        |

### Languages & runtimes

| Package           | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| `python`          | Python toolchain (pyenv / uv) and shell integration.       |
| `python_notebooks`| Jupyter / notebook-related config.                         |
| `ruby`            | Ruby version manager and gems setup.                       |
| `go`              | Go toolchain and `GOPATH`/`GOBIN` wiring.                  |
| `java`            | Java/JDK setup (SDKMAN!-based).                            |
| `clojure`         | Clojure / Leiningen / nREPL setup.                         |
| `haskell`         | Haskell toolchain (GHCup / cabal / stack).                 |
| `elixir`          | Elixir / Erlang setup.                                     |
| `npm`             | Node / npm config and global packages.                     |

### Databases & infra

| Package    | Description                                            |
| ---------- | ------------------------------------------------------ |
| `postgres` | PostgreSQL client config and helpers.                  |
| `docker`   | Docker / Docker Compose config.                        |
| `nix`      | Nix package manager setup (optional, not in profiles). |

### Version control & tooling

| Package    | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `git`      | `.gitconfig`, global ignore, hooks and aliases.              |
| `homebrew` | Homebrew bootstrapper (macOS and Linux).                     |

### macOS system

| Package       | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| `macos`       | `defaults write` tweaks for macOS UI/UX.                     |
| `karabiner`   | Karabiner-Elements key remapping config.                     |
| `logitech`    | Logitech Options/MX configuration.                           |
| `noclamshell` | Keeps the Mac awake when the lid is closed (clamshell mode). |
| `android`     | Android SDK / `adb` setup.                                   |

## Repository layout

```
.
├── install              # entry point — runs git setup + homebrew + profile
├── update               # pulls repo and updates packages for active profile
├── rc                   # sourced from ~/.zshrc to load per-package rc files
├── helpers              # shared shell helpers (link_files, run_*_step, is_macos, ...)
├── profiles/            # one file per machine (mac-personal, mac-work, homelab)
├── mac-apps/Brewfile    # desktop casks for macOS profiles (per-package Brewfile)
└── <package>/           # one directory per tool: install, setup, rc, update
```

Configurations included: Git, ZSH, Vim/Neovim, Tmux, Homebrew, Ruby, Python,
Go, Java, Clojure, Haskell, Elixir, Docker, PostgreSQL, Karabiner, Ghostty,
Kitty, Emacs, Logseq, Claude Code, Cursor, Gemini, OpenCode, Skills, and more.

## Inspirations

- https://github.com/holman/dotfiles
- https://github.com/mathiasbynens/dotfiles
