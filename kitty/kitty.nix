{ ... }:

{
  # Deploy the kitty config verbatim (portable plain-text config); home-manager
  # only symlinks it into ~/.config/kitty. The `kitty` package itself is
  # installed via packages.nix.
  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
}
