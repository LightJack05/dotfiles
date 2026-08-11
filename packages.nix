{ pkgs, config, ... }:
let
  gl = config.lib.nixGL.wrap;
in
{
  # General-purpose CLI tools not tied to any single config module. Everything
  # else now lives in the module that requires it (kitty in kitty/, tmux in
  # tmux/, screenshot/media/clipboard tools in hypr/, snx in snx/, ...), so it's
  # obvious why each package is installed.
  home.packages =
    (map gl (
      with pkgs;
      [
        firefox
        audacity
        blender
        kdePackages.ark
        easyeffects
        kdePackages.filelight
        gimp
        gnome-calculator
        gnome-keyring
        krita
        mpv
        obs-studio
        obsidian
        kdePackages.okular
        libreoffice-fresh

        openrgb
        paprefs
        pavucontrol
        pdfarranger
        seahorse

        steam
        system-config-printer
        tor-browser
      ]
    ))
    ++ (with pkgs; [
      ripgrep
      jq
      _7zz
      android-tools
      calf
      cowsay
      claude-code
      dmidecode
      fastfetch
      figlet
      fio
      github-cli
      gparted
      hexedit
      htop
      imv
      inetutils
      inotify-tools
      lolcat
      lshw
      mtr
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      ollama
      podman
      podman-compose
      progress
      rclone
      restic
      squashfsTools
      stow
      tea
      time
      tree
      unicode-emoji
      zip
      unzip
      wev
    ]);
}
