{ pkgs, config, snx, hyprmonitormanager, ... }:
let
  # home-manager's nixGL wrapper. Identity (no-op) when
  # targets.genericLinux.nixGL.packages is unset (e.g. on NixOS); a real nixGL
  # wrapper on non-NixOS where the flake sets it (see flake.nix).
  gl = config.lib.nixGL.wrap;
in
{
  home.packages =
    (with pkgs; [
      # CLI
      ripgrep
      jq
      tmux

      # Emoji picker (wofi-based). Self-contained: hardcodes its own wofi/
      # wtype/wl-clipboard, so it needs no PATH deps and no nixGL wrapping.
      wofi-emoji

      hypridle
      cliphist
      wl-clipboard
    ])
    ++ [
      # From flake inputs (not in nixpkgs)
      snx
      hyprmonitormanager
    ]
    # GPU-accelerated GUI apps — wrapped so they find the host drivers.
    ++ map gl (with pkgs; [
      kitty
      swaynotificationcenter # provides `swaync`
      waybar
      wofi
      hyprlock
      hyprpicker
      hyprpolkitagent
      thunar
      tumbler
      firefox
      satty
      grim
      slurp
      playerctl
    ]);
}
