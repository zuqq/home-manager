#!/usr/bin/env nix-shell
#!nix-shell --pure --keep NIX_PATH -i bash --packages cacert curl jq
#
# Bumps claude-code to the latest release (or the version passed as $1) by
# rewriting manifest.json with the darwin-arm64 entry from upstream.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

BASE_URL="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"

VERSION="${1:-$(curl -fsSL "$BASE_URL/latest")}"
echo "Updating claude-code to $VERSION" >&2

UPSTREAM_MANIFEST=$(curl -fsSL "$BASE_URL/$VERSION/manifest.json")
echo "$UPSTREAM_MANIFEST" | jq '{version, platforms: {"darwin-arm64": {checksum: .platforms["darwin-arm64"].checksum}}}' >manifest.json
