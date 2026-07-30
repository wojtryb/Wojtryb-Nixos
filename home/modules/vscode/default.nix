{ config, pkgs, ... }:

# Path to this position. Relative links cannot be used directly to reference current file
let current_path = "${builtins.toString ./.}"; in
{
  # Configuration files are symlinked to this repository, making them editable from within the program
  home.file.".config/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/keybindings.json";
  home.file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/settings.json";
}