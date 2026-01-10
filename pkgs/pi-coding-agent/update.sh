#!/usr/bin/env nix-shell
#!nix-shell --pure --keep NIX_PATH -i bash --packages nodejs nix-update git cacert

set -euo pipefail

version=$(npm view @mariozechner/pi-coding-agent version)

# Update version and hashes
AUTHORIZED=1 NIXPKGS_ALLOW_UNFREE=1 nix-update pi-coding-agent --version="$version" --generate-lockfile
