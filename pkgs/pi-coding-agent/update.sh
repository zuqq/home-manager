#!/usr/bin/env nix-shell
#!nix-shell --pure --keep NIX_PATH -i bash --packages nodejs nix-update git cacert

set -euo pipefail

version=$(npm view @earendil-works/pi-coding-agent version)

# Update version and hashes
nix-update pi-coding-agent --version="$version" --generate-lockfile
