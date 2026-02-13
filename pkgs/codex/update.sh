#!/usr/bin/env nix-shell
#!nix-shell --pure --keep NIX_PATH -i bash --packages nodejs nix-update git cacert

set -euo pipefail

version=$(npm view @openai/codex version)

# Update version and hashes
nix-update codex --version="$version" --generate-lockfile
