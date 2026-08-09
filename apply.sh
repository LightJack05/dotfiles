#/usr/bin/env bash
set -euxo pipefail

mkdir -p ~/.config/nix

cat << EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

nix run home-manager -- switch --flake .#default --impure
