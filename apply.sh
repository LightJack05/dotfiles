#/usr/bin/env bash
set -euxo pipefail

nix run home-manager -- switch --flake .#default --impure
