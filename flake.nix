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

  };

  outputs =
    { nixpkgs, home-manager, nixvim, ... }:
    let
      # Only used by the standalone (non-NixOS) path below.
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # For consumption from other flakes (e.g. your NixOS config).
      # Pure — no getEnv involved on this path.
      homeModules.default = ./home.nix;

      # Standalone use on Arch/Ubuntu/etc:
      #   home-manager switch --flake .#default --impure
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
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
