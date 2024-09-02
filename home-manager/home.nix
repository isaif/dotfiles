{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./kitty.nix
    ./git.nix
    ./stylix.nix
    ./lf.nix # file manager
  ];

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
    anki-bin
    mpv # general purpose media player required by anki
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.configFile.tmux.source = ../config/tmux;


  fonts.fontconfig.enable = true;

}
