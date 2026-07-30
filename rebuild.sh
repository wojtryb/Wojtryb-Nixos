#!/usr/bin/env bash

# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo nixos-rebuild switch --flake .#piotr
home-manager switch --flake .#ptryb@piotr