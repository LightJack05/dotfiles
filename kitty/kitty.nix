{ pkgs, config, ... }:

{
  # Deploy the kitty config verbatim (portable plain-text config); home-manager
  # only symlinks it into ~/.config/kitty.
  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;

  # kitty is GPU-accelerated → wrap with nixGL so it finds the host drivers.
  home.packages = [ (config.lib.nixGL.wrap pkgs.kitty) ];
}
