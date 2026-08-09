{ pkgs, config, ... }:

{
  # swaync config, deployed verbatim (portable).
  #
  # Note: the config file keeps its original name (swaync.json). swaync's own
  # default config path is ~/.config/swaync/config.json — if you rely on the
  # default, launch with `swaync -c ~/.config/swaync/swaync.json` or rename.
  xdg.configFile = {
    "swaync/swaync.json".source = ./swaync.json;
    "swaync/style.css".source = ./style.css;
  };

  # swaync (`swaynotificationcenter`) is GPU-accelerated → nixGL-wrapped.
  home.packages = [ (config.lib.nixGL.wrap pkgs.swaynotificationcenter) ];
}
