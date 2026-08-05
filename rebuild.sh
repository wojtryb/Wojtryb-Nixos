#!/usr/bin/env bash

# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# NOTE: run "nix-shell -p home-manager" to download HM

sudo nixos-rebuild switch --flake .#trybstation
home-manager switch --flake .#wojtryb@trybstation --impure