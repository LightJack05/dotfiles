{ pkgs, lib, config, ... }:

let
  home = config.home.homeDirectory;
in
{
  # Env vars (shell-agnostic; exported via hm-session-vars.sh).
  home.sessionVariables = {
    ANDROID_HOME = "${home}/Android/Sdk";
    JAVA_HOME = "/usr/lib/jvm/default"; # system JDK, not nix-managed
    MAKEFLAGS = "-j32";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # PATH additions (replaces the manual `export PATH=$PATH:...` lines).
  home.sessionPath = [
    "${home}/.dotnet/tools"
    "${home}/go/bin"
    "${home}/Android/Sdk/cmdline-tools/latest/bin"
    "${home}/Android/Sdk/platform-tools"
    "${home}/Android/Sdk/emulator"
  ];

  programs.zsh = {
    enable = true;

    # grml runs its own compinit, so we don't let home-manager also run one.
    enableCompletion = false;

    shellAliases = {
      nv = "nvim";
      vim = "nvim";
      v = "vim";
      neofetch = "fastfetch";
      m = "make";
      g = "git";
      c = "clear";
      p = "popd";
      k = "kubectl";
      mc = "mcli";
      help = "echo 'There is no escape for you, mortal!' | lolcat";

      # tmux-sessionizer helpers (scripts live in ~/bin, kept external)
      fs = ''CONFIG_FILE_NAME="tmux-sessionizer-source.conf" ~/bin/tmux-sessionizer/tmux-sessionizer'';
      fd = ''CONFIG_FILE_NAME="tmux-sessionizer-dir.conf" ~/bin/tmux-sessionizer/tmux-sessionizer 2> /dev/null'';
      fa = "tmux new -d -s";
      ff = "~/bin/tmux-sessionizer/find-session";

      # drop into zsh (not sh) inside nix shells
      nix-shell = "nix-shell --run zsh";
      nix-develop = "nix develop --command zsh";
    };

    initContent = lib.mkMerge [
      # Runs BEFORE the rest: bring in nix env, then hand control to grml,
      # which owns the prompt, keybindings and completion system.
      (lib.mkBefore ''
        if [ -e /etc/profile.d/nix.sh ]; then
          . /etc/profile.d/nix.sh
        fi

        source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
      '')

      # Runs AFTER grml is loaded (so grml_theme_add_token / compinit exist).
      (lib.mkAfter ''
        # --- NIX shell-indicator token for the grml prompt (from old nix.sh) ---
        function nix_shell_prompt () {
          if [[ -n "$IN_NIX_SHELL" ]]; then
            REPLY="[%F{cyan}NIX%f] "
          else
            REPLY=""
          fi
        }

        if (( ''${+functions[grml_theme_add_token]} )); then
          grml_theme_add_token nix-shell -f nix_shell_prompt ''' '%f'
          zstyle ':prompt:grml:left:setup' items rc change-root user at host path vcs nix-shell percent
          zstyle ':prompt:grml-large:left:setup' items rc jobs history shell-level change-root time date newline user at host path vcs nix-shell percent
          zstyle ':prompt:grml-chroot:left:setup' items grml-chroot user at host path nix-shell percent
        fi

        # --- tool completions (carry-over; drop each as its tool moves to nix) ---
        for _f in ${./completions}/*.sh; do . "$_f"; done; unset _f
      '')
    ];
  };
}
