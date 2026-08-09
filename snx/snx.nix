{ snx, ... }:

{
  # snx config, deployed verbatim (portable).
  xdg.configFile."snx/config.toml".source = ./config.toml;
  xdg.configFile."snx/snippets".source = ./snippets;

  # snx package comes from its own flake input (passed via extraSpecialArgs).
  home.packages = [ snx ];
}
