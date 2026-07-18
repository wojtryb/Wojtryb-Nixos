#!/usr/bin/env bash

# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo nixos-rebuild switch --flake .#trybstation
home-manager switch --flake .#wojtryb@trybstation