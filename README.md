# Dotfiles

Setup clean computers.

Based on some old version of [Holman's approach](https://github.com/holman/dotfiles).

## Using

### Setup git configuration

1. Copy gitconfig file

```bash
$ cp git/gitconfig.symlink.example git/gitconfig.symlink
```

2. Fill it with your information

```
[user]
  name = YOUR FULL NAME HERE
  email = YOUR EMAIL HERE
```

### Running scripts

For full installation you need to run the root `install.sh`.

```bash
$ ./install.sh
```

#### WARNING: `./install.sh` overrides any configuration file existent on your home folder.

You can run individual installations if you want. Check `install.sh` inside subfolders.

```bash
$ ./git/install.sh # => Git installation
$ ./homebrew/install.sh # => Homebrew setup and installation
$ ./ruby/install.sh # => Ruby environment setup
```
