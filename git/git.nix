{ ... }:

{
  # Hyprland is managed by the OS (Arch) since it must be registered for all
  # users; home-manager only deploys the config. These are Hyprland 0.56+ native
  # Lua configs (the `hl` API) plus the plain hypridle/hyprlock/hyprpaper confs.
  #
  # Files are symlinked individually (not the whole ~/.config/hypr dir) on
  # purpose: display.lua is generated at runtime by hyprmonitormanager and must
  # stay a real, writable file, so the directory itself is left unmanaged.
  home.file.".gitconfig".source = ./.gitconfig;
}
