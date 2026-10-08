#/usr/bin/env bash
set -euxo pipefail

cd /home/LightJack05/dotfiles/

sudo cp -rv ./root/* /

mkdir -p ~/.config/nix

cat << EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
