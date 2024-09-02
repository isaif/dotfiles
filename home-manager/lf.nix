{ ... }:

{
  programs.lf = {
    enable = true;
    extraConfig = ''
      cmd z %{{
          result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
      }}
    '';
  };

}
