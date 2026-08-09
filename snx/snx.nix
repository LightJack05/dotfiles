{ ... }:

{
  # snx config, deployed verbatim (portable). The `snx` package itself is
  # installed via packages.nix (it comes from the snx flake input).
  xdg.configFile."snx/config.toml".source = ./config.toml;
}
