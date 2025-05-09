# Dotfiles

Personal machine setup.

## Using

### Prerequisites

1. Make sure you have Git installed
2. Clone this repository to your home directory:
```bash
git clone https://github.com/lucasalencar/dotfiles.git ~/.dotfiles
```

### Setup git configuration

1. Copy gitconfig file
```bash
cp git/.gitconfig.symlink git/.gitconfig
```

2. Fill it with your information
```
[user]
  name = YOUR FULL NAME HERE
  email = YOUR EMAIL HERE
```

### Installation

The installation process supports different profiles for different setups. Available profiles are:
- `basic`: Essential packages and configurations
- `personal`: Personal development environment
- `nubank`: My work environment setup

Profiles are listed at profile folder.

To install with a specific profile:
```bash
./install personal  # For personal setup
./install nubank    # For work setup
```

Or for basic installation only:
```bash
./install
```

#### WARNING: The installation process will override existing configuration files in your home directory.

### Package Installation

You can also run individual installations if you prefer. Each directory contains its own `install.sh` script:

```bash
$ ./git/install.sh      # Git installation
$ ./homebrew/install.sh # Homebrew setup and installation
$ ./ruby/install.sh     # Ruby environment setup
$ ./zsh/install.sh      # ZSH configuration
$ ./vim/install.sh      # Vim configuration
$ ./nvim/install.sh     # Neovim configuration
$ ./tmux/install.sh     # Tmux configuration
```

## Available Configurations

This dotfiles repository includes configurations for:
- Git
- ZSH
- Vim/Neovim
- Tmux
- Homebrew
- Ruby
- Python
- Go
- Java
- Clojure
- Haskell
- Elixir
- Docker
- PostgreSQL
- And more...

# Inspirations

- https://github.com/holman/dotfiles
