{ ... }:

{
  # Config files for the packaged tmux helper scripts (tmux-sessionizer,
  # tmux-git-finder, etc.). Deployed verbatim (portable) — the scripts
  # themselves are flake inputs referenced from tmux/tmux.nix.
  #
  # Note: tmux-kube-context has no corresponding flake input/package here (the
  # kubeconfig tmux script was dropped); its config is kept for parity.
  xdg.configFile = {
    "tmux-git-cloner/config".source = ./tmux-git-cloner/config;
    "tmux-git-finder/config".source = ./tmux-git-finder/config;
    "tmux-kube-context/config".source = ./tmux-kube-context/config;
    "tmux-nix-finder/config".source = ./tmux-nix-finder/config;
    "tmux-scratchpad/config".source = ./tmux-scratchpad/config;
    "tmux-sessionizer/tmux-sessionizer-dir.conf".source = ./tmux-sessionizer/tmux-sessionizer-dir.conf;
    "tmux-sessionizer/tmux-sessionizer-source.conf".source = ./tmux-sessionizer/tmux-sessionizer-source.conf;
    "tmux-sessionizer/tmux-sessionizer-global.conf".source = ./tmux-sessionizer/tmux-sessionizer-global.conf;
  };
}
