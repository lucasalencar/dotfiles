{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.coreutils
      pkgs.fd
      pkgs.ag
      pkgs.ripgrep
      pkgs.htop
      pkgs.tree
      pkgs.colordiff
      pkgs.jq
      pkgs.fzf
      pkgs.git
      pkgs.git-lfs

      # Terms
      pkgs.kitty
      pkgs.oh-my-zsh
      pkgs.tmux

      # Makes copying and pasting in Terminal.app work again on MacOS Sierra
      # https://github.com/tmux/tmux/issues/543#issuecomment-248980734
      # https://github.com/tmux/tmux/issues/543
      pkgs.reattach-to-user-namespace

      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.yank
      pkgs.tmuxPlugins.copycat
      pkgs.tmuxPlugins.open

      # Editors
      pkgs.vim
      pkgs.neovim
      pkgs.emacsMacport

      pkgs.vimPlugins.vim-plug

      # Bash
      pkgs.shellcheck

      # Clojure
      pkgs.clojure
      pkgs.joker
      pkgs.clj-kondo
      pkgs.clojure-lsp

      # Elixir
      pkgs.elixir

      # Node
      pkgs.nodejs

      # Ruby
      pkgs.rbenv
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableFzfHistory = true;
  };

  # Enable the Emacs Daemon. Run emacs as a service
  services.emacs.enable = true;

  environment.shellAliases = {
    # Use emacsclient to open files in current emacs instance server
    emacs = "emacsclient -cn";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
