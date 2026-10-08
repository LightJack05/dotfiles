#/usr/bin/env bash
set -euxo pipefail

export NIXPKGS_ALLOW_UNFREE=1

nix run home-manager -- switch --flake .#default --impure
