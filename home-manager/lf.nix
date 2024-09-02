{ ... }:

{
  programs.lf = {
    enable = true;
    extraConfig = ''
      # zoxide integration
      cmd z %{{
          result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
      }}


      # Move up/down in the parent directory
      cmd move-parent &{{
          dironly="setlocal \"$(dirname -- "$PWD" | sed 's/\\/\\\\/g;s/"/\\"/g')\" dironly"
          lf -remote "send $id :updir; $dironly true; $1; $dironly false; open"
      }}

      map J move-parent down
      map K move-parent up


      # Show progress for file copying
      cmd paste &{{
      set -- $(cat ~/.local/share/lf/files)
      mode="$1"
      shift
      case "$mode" in
          copy)
              rsync -av --ignore-existing --progress -- "$@" . |
              stdbuf -i0 -o0 -e0 tr '\r' '\n' |
              while IFS= read -r line; do
                  line="$(printf '%s' "$line" | sed 's/\\/\\\\/g;s/"/\\"/g')"
                  lf -remote "send $id echo \"$line\""
              done
              ;;
          move) mv -n -- "$@" .;;
      esac
      rm ~/.local/share/lf/files
      lf -remote "send clear"
      }}
    '';
  };

}
