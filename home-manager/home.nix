{ config, pkgs, ... }:

{
  home.username = "saif";
  home.homeDirectory = "/home/saif";


  home.packages = with pkgs; [
    fzf
    ripgrep
    tree
    kitty
    htop
    tmux
    neovim
    fd
    sqlite
    lf
    dconf # required by gtk.enable
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  #programs.neovim.enable = true;

  programs.zsh.enable= true;
  programs.zoxide.enable= true;
  programs.zoxide.enableZshIntegration = true;

  xdg.enable = true;
  xdg.configFile.nvim.source = ../config/nvim;
  xdg.configFile.tmux.source = ../config/tmux;
  xdg.configFile.kitty.source = ../config/kitty;

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
    userEmail = "isaifmd@gmail.com";
    userName = "saif";
  };

  home.sessionVariables = {
    EDITOR="vim";
    TERM="kitty";
  };
}
