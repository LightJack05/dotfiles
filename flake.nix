{
  description = "Home configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tmux-git-finder = {
      url = "git+https://gitea.lightjack.de/LightJack05/tmux-git-finder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-sessionizer = {
      url = "git+https://gitea.lightjack.de/LightJack05/tmux-sessionizer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-scratchpad = {
      url = "git+https://gitea.lightjack.de/LightJack05/tmux-scratchpad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-nix-finder = {
      url = "git+https://gitea.lightjack.de/LightJack05/tmux-nix-finder";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-git-cloner = {
      url = "git+https://gitea.lightjack.de/LightJack05/tmux-git-cloner";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprmonitormanager = {
      url = "git+https://gitea.lightjack.de/LightJack05/hyprmonitormanager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ nixpkgs, home-manager, nixvim, ... }:
    let
      # Only used by the standalone (non-NixOS) path below.
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};

      # Packaged helper scripts (each a standalone flake input above).
      tmuxScripts = {
        git-finder = inputs.tmux-git-finder.packages.${system}.default;
        sessionizer = inputs.tmux-sessionizer.packages.${system}.default;
        scratchpad = inputs.tmux-scratchpad.packages.${system}.default;
        nix-finder = inputs.tmux-nix-finder.packages.${system}.default;
        git-cloner = inputs.tmux-git-cloner.packages.${system}.default;
      };
    in
    {
      # For consumption from other flakes (e.g. your NixOS config).
      # Pure — no getEnv involved on this path.
      homeModules.default = ./home.nix;

      # Standalone use on Arch/Ubuntu/etc:
      #   home-manager switch --flake .#default --impure
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit tmuxScripts; };
        modules = [
          nixvim.homeModules.nixvim
          ./home.nix
          {
            home.username = username;
            home.homeDirectory = homeDirectory;
          }
        ];
      };
    };
}
