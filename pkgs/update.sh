#!/usr/bin/env bash

# `nix-update` only works when run in the directory containing `update.sh`; run
# this wrapper script from `..` to update all the packages in `pkgs/`.

for d in pkgs/*; do
    [ -x "$d/update.sh" ] || continue
    (cd "$d" && ./update.sh)
done
