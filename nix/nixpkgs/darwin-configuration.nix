{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.coreutils
      pkgs.binutils
      pkgs.diffutils
      pkgs.findutils
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

  # Enable nix auto gc
  # nix.gc.automatic = true;
  # nix.gc.interval = { Hour = 24; };
  # nix.gc.options = "-d";

  # Create /etc/zshrc that loads the nix-darwin environment.
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

    nixre = "darwin-rebuild switch";
    nixgc = "nix-collect-garbage -d";
  };

  ## MacOS flags

  # Set dark mode
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";

  system.defaults.NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
  system.defaults.NSGlobalDomain.AppleMetricUnits = 1;
  system.defaults.NSGlobalDomain.AppleTemperatureUnit = "Celsius";

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = "0";
  system.defaults.dock.enable-spring-load-actions-on-all-items = true;
  system.defaults.dock.expose-animation-duration = "0.1";
  system.defaults.dock.expose-group-by-app = false;
  system.defaults.dock.mineffect = "scale";
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.show-process-indicators = true;
  system.defaults.dock.showhidden = true;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 50;

  # Trackpad
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1; # tap to click
  system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;

  # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;

  # Set a blazingly fast keyboard repeat rate
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;

  # Medium size sidebar Finder icons
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;

  # Open folder when holding some file over it
  system.defaults.NSGlobalDomain."com.apple.springing.enabled" = true;
  system.defaults.NSGlobalDomain."com.apple.springing.delay" = "0.5";

  # Expand save panel by default
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  # Save to disk (not iCloud) by default
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

  # Disable the press-and-hold feature in favor of key repeat
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  # Increase window resize animation speed
  system.defaults.NSGlobalDomain.NSWindowResizeTime = "0.001";

  # Disable automatic changes to text as its annoying when typing code
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # Disable the 'Are you sure you want to open this application?' dialog
  system.defaults.LaunchServices.LSQuarantine = false;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
