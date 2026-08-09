{ ... }:

{
  # wofi config, deployed verbatim (portable). The `wofi` package is installed
  # via packages.nix.
  xdg.configFile."wofi/style.css".source = ./style.css;
}
