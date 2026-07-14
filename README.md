# Dotfiles

Personal machine setup. Centralized configuration for shell, editors, version
managers and CLI tooling, organized by **profile** so the same repository can
bootstrap a basic, a personal or a work machine.

## How it works

The repository is organized as a collection of **packages** (one per top-level
directory: `git/`, `zsh/`, `vim/`, `homebrew/`, ...) and **profiles**
(`profiles/basic`, `profiles/personal`, `profiles/nubank`).

A profile is just a plain-text list of package names. Running `./install
<profile>` will, for each package in that profile:

1. Run its `install` script (if present) — installs binaries / clones plugins.
2. Run its `setup` script (if present) — symlinks dotfiles into `$HOME`.
3. Source its `rc` file (if present) on every new shell, via the top-level
   `rc` loader.

Each profile also has a matching `homebrew/Brewfiles/<profile>` that is applied
through `brew bundle` before the per-package installers run.

## Available profiles

| Profile    | Use case                                          |
| ---------- | ------------------------------------------------- |
| `basic`    | Essential packages, applied to every machine.     |
| `personal` | Personal development environment (extra tooling). |
| `nubank`   | Work environment for my job at Nubank.            |

`basic` is always installed. Selecting `personal` or `nubank` installs that
profile **on top of** `basic`.

## Setup

### Prerequisites

- macOS (the scripts assume `brew` and macOS conventions).
- Git installed and available on `PATH`.

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
./install              # basic only
./install personal     # basic + personal
./install nubank       # basic + nubank (work)
```

What `./install` does, in order:

1. Initializes `~/.gitconfig` from `git/.gitconfig.example`, prompting for
   your Git author name and email (`git/pre-setup`).
2. Installs Homebrew if missing (`homebrew/install`).
3. Runs `brew bundle` for the `basic` profile, then installs/sets up each
   `basic` package.
4. If a profile was passed, repeats step 3 for that profile and stores its
   name in `.current_profile` so `rc` knows which profile to load on shell
   startup.

### 3. Reload your shell

Open a new terminal (or `source ~/.zshrc`) so the new dotfiles take effect.

## Updating

```bash
./update                 # pull repo + update everything for the active profile
./update <package> ...   # update only the listed package(s)
```

With no arguments, `./update` will:

1. `git pull --rebase` the dotfiles repo.
2. Update Homebrew packages.
3. Re-run `brew bundle` and per-package `update` scripts for `basic` and the
   profile recorded in `.current_profile`.

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

## Adding new Homebrew packages

Add the formula/cask to the appropriate file under `homebrew/Brewfiles/`
(`basic`, `personal`, or `nubank`) and re-run:

```bash
./bundle <profile>     # apply a single profile's Brewfile
./install <profile>    # full install (also runs bundle)
```

## Available packages

Each item below maps to a top-level directory in this repo. Most are wired up
through one of the profiles; a few (`homelab`, `nix`, ...) are
optional and only used when explicitly invoked.

### Shell & terminal

| Package        | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| `zsh`          | ZSH shell config, plugins and prompt.                          |
| `tmux`         | Tmux config, plugins and key bindings.                         |
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
| `claude-code`| Claude Code settings, custom commands, hooks and tmux MCP.   |
| `codex`      | Codex CLI configuration and key bindings.                    |
| `gemini`     | Gemini CLI configuration.                                    |
| `opencode`   | OpenCode agent configuration.                                |
| `prompts`    | Reusable prompt snippets shared across tools.                |

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
| `homelab`  | Personal homelab tooling (optional, not in profiles).  |
| `nix`      | Nix package manager setup (optional, not in profiles). |

### Version control & tooling

| Package    | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `git`      | `.gitconfig`, global ignore, hooks and aliases.              |
| `homebrew` | Homebrew bootstrapper and per-profile `Brewfile`s.           |

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
├── bundle               # runs `brew bundle` for one or more profiles
├── rc                   # sourced from ~/.zshrc to load per-package rc files
├── helpers              # shared shell helpers (link_files, run_*_step, ...)
├── profiles/            # one file per profile, listing the packages to install
├── homebrew/Brewfiles/  # one Brewfile per profile
└── <package>/           # one directory per tool: install, setup, rc, update
```

Configurations included: Git, ZSH, Vim/Neovim, Tmux, Homebrew, Ruby, Python,
Go, Java, Clojure, Haskell, Elixir, Docker, PostgreSQL, Karabiner, Ghostty,
Kitty, Emacs, Logseq, Claude Code, Cursor, Gemini, OpenCode, and more.

## Inspirations

- https://github.com/holman/dotfiles
- https://github.com/mathiasbynens/dotfiles
