{ pkgs, config, ... }:

{
  # waybar config, deployed verbatim (portable).
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = ./style.css;
  };

  # waybar is GPU-accelerated → nixGL-wrapped.
  home.packages = [ (config.lib.nixGL.wrap pkgs.waybar) ];
}
