{ ... }:

{
  programs.lf = {
    enable = true;
    extraConfig = ''
      cmd z %{{
          result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
      }}

      cmd move-parent &{{
          dironly="setlocal \"$(dirname -- "$PWD" | sed 's/\\/\\\\/g;s/"/\\"/g')\" dironly"
          lf -remote "send $id :updir; $dironly true; $1; $dironly false; open"
      }}

      map J move-parent down
      map K move-parent up
    '';
  };

}
