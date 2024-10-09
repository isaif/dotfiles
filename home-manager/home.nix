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
    smug # tmux session manager
    neovim
    tree-sitter # optional dependency of neovim
    sqlite
    dconf # required by gtk.enable
    xclip # clipboard for copy and paste
    # devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
    devbox # devenv alternative
    direnv # required by devenv and devbox
    # direnv-nix
    gh # GitHub CLI tool

    vscode-fhs # Wrapped variant of vscode which launches in a FHS compatible environment
    zed-editor # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter

    qutebrowser # Keyboard-focused browser with a minimal GUI

    # lua language
    lua51Packages.lua
    lua51Packages.luarocks
    lua-language-server # lsp
    stylua # formatter

    # nix language
    nil # lsp
    nixpkgs-fmt # formatter

    # awmtt
    anki-bin
    mpv # general purpose media player required by anki

    sioyek # pdf reader

    workrave
    libnotify
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  xdg.enable = true;

  # run home-manager switch --flake to make changes in config take effect
  xdg.configFile.tmux.source = ../config/tmux;

  fonts.fontconfig.enable = true;

}
