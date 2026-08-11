{ pkgs, config, ... }:
let
  gl = config.lib.nixGL.wrap;
in
{
  home.packages = (
    map gl (
      with pkgs;
      [
        firefox
        audacity
        blender
        kdePackages.ark
        easyeffects
        kdePackages.filelight
        gimp
        gparted
        gnome-calculator
        gnome-keyring
        krita
        imv
        mpv
        obs-studio
        obsidian
        kdePackages.okular
        libreoffice-fresh

        blueman # blueman-manager — waybar bluetooth on-click
        networkmanagerapplet # nm-applet — hyprland autostart tray
        openrgb
        paprefs
        pavucontrol
        pdfarranger
        seahorse

        steam
        system-config-printer
        tor-browser
      ]
    )
  );
}
