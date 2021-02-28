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

  system.defaults = {
    # Set dark mode
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";

    NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
    NSGlobalDomain.AppleMetricUnits = 1;
    NSGlobalDomain.AppleTemperatureUnit = "Celsius";

    # Trackpad
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1; # tap to click
    NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;

    # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
    NSGlobalDomain.AppleKeyboardUIMode = 3;


    # Set a blazingly fast keyboard repeat rate
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain.InitialKeyRepeat = 10;

    # Medium size sidebar Finder icons
    NSGlobalDomain.NSTableViewDefaultSizeMode = 2;

    # Open folder when holding some file over it
    NSGlobalDomain."com.apple.springing.enabled" = true;
    NSGlobalDomain."com.apple.springing.delay" = "0.5";

    # Expand save panel by default
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

    # Save to disk (not iCloud) by default
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

    # Disable the press-and-hold feature in favor of key repeat
    NSGlobalDomain.ApplePressAndHoldEnabled = false;

    # Increase window resize animation speed
    NSGlobalDomain.NSWindowResizeTime = "0.001";

    # Disable automatic changes to text as its annoying when typing code
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

    # Disable the 'Are you sure you want to open this application?' dialog
    LaunchServices.LSQuarantine = false;

    dock.autohide = true;
    dock.autohide-delay = "0";
    dock.enable-spring-load-actions-on-all-items = true;
    dock.expose-animation-duration = "0.1";
    dock.expose-group-by-app = false;
    dock.mineffect = "scale";
    dock.minimize-to-application = true;
    dock.show-process-indicators = true;
    dock.showhidden = true;
    dock.show-recents = false;
    dock.tilesize = 50;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
