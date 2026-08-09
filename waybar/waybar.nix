{ ... }:

{
  # waybar config, deployed verbatim (portable). The `waybar` package is
  # installed via packages.nix.
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = ./style.css;
  };
}
