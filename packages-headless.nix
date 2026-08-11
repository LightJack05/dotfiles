{ pkgs, ... }:
{
  home.packages = (
    with pkgs;
    [
      jq
      _7zz
      android-tools
      brightnessctl # XF86MonBrightness keybinds (hypr)
      calf
      cowsay
      claude-code
      dmidecode
      fastfetch
      figlet
      fio
      github-cli
      hexedit
      htop
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
    ]
  );
}
