{ config, pkgs, ... }:

{
  home.username = "james";
  home.homeDirectory = "/home/james";

  home.packages = with pkgs; [
    gnumake
    jq
    nnn
    go
    k9s
    nodejs_20
    corepack_20
  ];

  home.file.".bash_profile" = {
    text = ''
      [[ $TERM != "tmux-256color" ]] && exec tmux;
    '';
  };

  programs.git = {
    enable = true;
    userName  = "Jamess-Lucass";
    userEmail = "23193271+Jamess-Lucass@users.noreply.github.com";
    
    extraConfig = {
      color.ui = true;
      diff.colorMoved = "zebra";
      fetch.prune = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {theme = "catppuccin";};
    themes = {
      catppuccin = {
        src =
          pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
        file = "Catppuccin-macchiato.tmTheme";
      };
    };
  };

  programs.tmux = {
    enable = true;

    plugins = with pkgs;
      [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.catppuccin
      ];

    extraConfig = ''
      setw -g mouse on
    '';
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    initExtra = ''
      n () {
        if [ -n $NNNLVL ] && [ "$NNNLVL" -ge 1 ]; then
          echo "nnn is already running"
          return
        fi

        export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

        nnn -adeHo "$@"

        if [ -f "$NNN_TMPFILE" ]; then
          . "$NNN_TMPFILE"
          rm -f "$NNN_TMPFILE" > /dev/null
        fi
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    shellAliases = {
      cat = "bat";
      ll = "n";
    };

    syntaxHighlighting = {
      enable = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
