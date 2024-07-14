{ config, pkgs, ... }:

{
  home.username = "saif";
  home.homeDirectory = "/home/saif";


  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    tree
    htop
    tmux
    neovim
    sqlite
    lf # file manager
    dconf # required by gtk.enable
    xclip # clipboard for copy and paste

    # lua language
    lua51Packages.lua
    lua51Packages.luarocks
    lua-language-server # lsp
    stylua # formatter

    nodejs_22
    python3

    # nix language
    nil # lsp
    nixpkgs-fmt # formatter

    # awmtt
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      v = "nvim";
    };

    initExtra = ''
      bindkey jj vi-cmd-mode 

      # Powerlevel10k Zsh theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/nix-config/p10k.zsh && source ~/nix-config/p10k.zsh
    '';
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    # ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "zoxide"
        "podman"
        "docker"
        "docker-compose"
        "vi-mode"
        # "command-not-found"
        # "history"
      ];
    };
  };
  programs.zoxide.enableZshIntegration = true;

  xdg.enable = true;
  xdg.configFile.tmux.source = ../config/tmux;

  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      cursor = "none"; # not working because of stylix, it should invert color of cursor
      cursor_shape = "block";
      cursor_blink_interval = 0;
      font_size = "11";
    };
  };

  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
    image = /home/saif/nix-config/home-manager/wall.jpeg;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" ]; };
        name = "JetBrainsMono NFM";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

    fonts.sizes = {
      applications = 10;
      terminal = 8;
      desktop = 10;
      popups = 10;
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };

    polarity = "dark"; # "light" or "either"
    targets.kitty.variant256Colors = true;
  };

  programs.git = {
    enable = true;
    userName = "isaif";
    userEmail = "saif935775@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "$VISUAL";
    # TERM="kitty";
  };
}
