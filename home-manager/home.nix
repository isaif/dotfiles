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
