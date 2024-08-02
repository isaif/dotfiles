{ ... }:

{
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
}
