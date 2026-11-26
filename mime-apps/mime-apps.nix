{ ... }:

{
  # Deploy the kitty config verbatim (portable plain-text config); home-manager
  # only symlinks it into ~/.config/kitty.
  xdg.configFile."mime-apps.list".source = ./mime-apps.list;
}
