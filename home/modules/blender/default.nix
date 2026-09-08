{ config, pkgs, ... }:

# Path to this position. Relative links cannot be used directly to reference current file
# let current_path = "${builtins.toString ./.}"; in
let current_path = "${config.home.homeDirectory}/Code/Wojtryb-Nixos/home/modules/blender"; in
{
  # hardcopy - blender overwrites the file. Symlink not applicable
  home.file.".config/blender/5.2/config/startup.blend".source = ./startup.blend;
  home.file.".config/blender/5.2/config/userpref.blend".source = ./userpref.blend;
  # hardcopy - blender does not allow to overwrite the file
  home.file.".config/blender/5.2/scripts/presets/keyconfig/wojtryb.py".source = ./wojtryb.py;
  # symlink - file edited externally
  home.file.".config/blender/5.2/scripts/addons/core_settings_panel.py".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/core_settings_panel.py";
}
