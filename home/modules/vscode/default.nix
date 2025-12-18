{ config, pkgs, ... }:

# TODO: Find a way to get current path from nix
# Path to this position. Relative links cannot be used to reference current file
let current_path = "${config.home.homeDirectory}/Code/Wojtryb-Nixos/home/modules/vscode"; in
{

  # Configuration files are symlinked to this repository, making them editable from within the program
  home.file.".config/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/keybindings.json";
  home.file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/settings.json";
}