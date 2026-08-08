{ ... }:

{
  # Deploy the tmux config verbatim. Kept as plain, standalone tmux config
  # files (portable — usable even without nix); home-manager only symlinks
  # them into ~/.config/tmux. tmux.conf sources theme.conf via its normal
  # ~/.config/tmux/theme.conf path, so nothing inside the configs changes.
  xdg.configFile = {
    "tmux/tmux.conf".source = ./tmux.conf;
    "tmux/theme.conf".source = ./theme.conf;
  };
}
