{ pkgs, config, ... }:

let
  gl = config.lib.nixGL.wrap;
in
{
  # Hyprland itself is managed by the OS (Arch) since it must be registered for
  # all users; home-manager only deploys the config. These are Hyprland 0.56+
  # native Lua configs (the `hl` API) plus the plain hypridle/hyprlock/hyprpaper
  # confs.
  #
  # Files are symlinked individually (not the whole ~/.config/hypr dir) on
  # purpose: display.lua is generated at runtime by hyprmonitormanager and must
  # stay a real, writable file, so the directory itself is left unmanaged.
  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland.lua;
    "hypr/keymaps.lua".source = ./keymaps.lua;
    "hypr/workspace-rules.lua".source = ./workspace-rules.lua;
    "hypr/keymaps".source = ./keymaps; # whole submap tree
    "hypr/hypridle.conf".source = ./hypridle.conf;
    "hypr/hyprlock.conf".source = ./hyprlock.conf;
    "hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    "hypr/.luarc.json".source = ./.luarc.json; # editor/LSP stubs pointer only
  };

  # Tools invoked from the Hyprland config above (autostart + keybinds).
  home.packages =
    (map gl (with pkgs; [
      # Hyprland ecosystem
      hyprpicker # SUPER+x color picker
      hyprpaper
      xdg-desktop-portal-hyprland
      # Screenshot pipeline (Print: grim | slurp | satty)
      grim
      slurp
      satty
      # Media keys
      playerctl
      # File manager (SUPER+E) + its thumbnailer
      thunar
      tumbler
    ]))
    ++ (with pkgs; [
      hypridle # idle daemon (autostart)
      cliphist # clipboard history (autostart + SUPER+V)
      wl-clipboard # wl-copy / wl-paste (clipboard + color picker)
    ]);
}
