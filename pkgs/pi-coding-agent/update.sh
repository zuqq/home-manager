#!/usr/bin/env nix-shell
#!nix-shell --pure --keep NIX_PATH -i bash --packages nodejs nix-update curl jq git cacert

set -euo pipefail

scope="@earendil-works"
version=$(npm view "$scope/pi-coding-agent" version)

sibling_integrity() {
    curl -fsSL "https://registry.npmjs.org/$scope/$1/$version" | jq -er .dist.integrity
}

pi_agent_core=$(sibling_integrity pi-agent-core)
pi_ai=$(sibling_integrity pi-ai)
pi_tui=$(sibling_integrity pi-tui)
jq -n --arg pi_agent_core "$pi_agent_core" --arg pi_ai "$pi_ai" --arg pi_tui "$pi_tui" '{
    packages: {
        "node_modules/@earendil-works/pi-agent-core": {integrity: $pi_agent_core},
        "node_modules/@earendil-works/pi-ai": {integrity: $pi_ai},
        "node_modules/@earendil-works/pi-tui": {integrity: $pi_tui}
    }
}' >shrinkwrap-patch.json

nix-update pi-coding-agent --version="$version"
