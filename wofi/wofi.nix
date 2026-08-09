{ pkgs, config, ... }:

{
  # wofi config, deployed verbatim (portable).
  xdg.configFile."wofi/style.css".source = ./style.css;

  home.packages = [
    # wofi is GPU-accelerated → nixGL-wrapped.
    (config.lib.nixGL.wrap pkgs.wofi)
    # Emoji picker (wofi-based). Self-contained: hardcodes its own wofi/wtype/
    # wl-clipboard, so it needs no PATH deps and no nixGL wrapping.
    pkgs.wofi-emoji
  ];
}
