{ tmuxScripts, ... }:

let
  # Keep tmux.conf as the single, human-readable source of truth (still a plain
  # tmux config). At build time we only rewrite the hard-coded ~/bin/<script>/
  # prefixes to the nix store paths of the packaged helper scripts, so the
  # deployed config points at the versioned nix packages instead of loose files.
  tmuxConf = builtins.replaceStrings
    [
      "~/bin/tmux-sessionizer/"
      "~/bin/tmux-git-finder/"
      "~/bin/tmux-nix-finder/"
      "~/bin/tmux-git-cloner/"
      "~/bin/tmux-scratchpad/"
    ]
    [
      "${tmuxScripts.sessionizer}/bin/"
      "${tmuxScripts.git-finder}/bin/"
      "${tmuxScripts.nix-finder}/bin/"
      "${tmuxScripts.git-cloner}/bin/"
      "${tmuxScripts.scratchpad}/bin/"
    ]
    (builtins.readFile ./tmux.conf);
in
{
  xdg.configFile = {
    "tmux/tmux.conf".text = tmuxConf;
    "tmux/theme.conf".source = ./theme.conf;
  };
}
