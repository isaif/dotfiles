{ pkgs, ... }:

{
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

      tfzf-widget() {
        BUFFER="tfzf"
        zle accept-line
      }
      zle -N tfzf-widget
      # Alt+space to run
      bindkey '^[ ' tfzf-widget

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
        "zoxide"
        "podman"
        "docker"
        "docker-compose"
        "vi-mode"
        "fzf"
        "direnv"
        # "command-not-found"
        # "history"
      ];
    };
  };

  programs.zoxide.enable = true;

}
