#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo nixos-rebuild -I nixos-config=$SCRIPT_DIR/machine/configuration.nix switch
home-manager switch -f $SCRIPT_DIR/home/home.nix