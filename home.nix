{ pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./zsh/zsh.nix
    ./tmux/tmux.nix
    ./tmux-scripts/tmux-scripts.nix
    ./nvim/nvim.nix
    ./kitty/kitty.nix
    ./snx/snx.nix
    ./swaync/swaync.nix
    ./waybar/waybar.nix
    ./wofi/wofi.nix
    ./hypr/hypr.nix
    ./hyprmonitormanager/hyprmonitormanager.nix
    ./git/git.nix
    ./ssh/ssh.nix
    ./theme/theme.nix
    ./mime-apps/mime-apps.nix
  ];

  # home.username / home.homeDirectory are supplied by the flake's
  # inline module (see flake.nix homeConfigurations.default).

  # Compatibility pin — set once at creation, never bump casually.
  home.stateVersion = "26.05";

  # Let home-manager manage itself (gives you the `home-manager` CLI
  # after the first bootstrap `nix run`).
  programs.home-manager.enable = true;

  # Session variables (exported via hm-session-vars.sh — make sure your
  # shell sources it, see README note).
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
