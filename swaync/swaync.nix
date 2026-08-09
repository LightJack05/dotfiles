{ ... }:

{
  # swaync config, deployed verbatim (portable). The `swaynotificationcenter`
  # package (`swaync`) is installed via packages.nix.
  #
  # Note: the config file keeps its original name (swaync.json). swaync's own
  # default config path is ~/.config/swaync/config.json — if you rely on the
  # default, launch with `swaync -c ~/.config/swaync/swaync.json` or rename.
  xdg.configFile = {
    "swaync/swaync.json".source = ./swaync.json;
    "swaync/style.css".source = ./style.css;
  };
}
