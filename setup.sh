#/usr/bin/env bash
set -euxo pipefail

sudo cp -rv ./root/* /

mkdir -p ~/.config/nix

cat << EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

./apply.sh
