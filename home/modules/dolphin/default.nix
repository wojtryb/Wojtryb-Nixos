{ config, pkgs, ... }:

# Path to this position. Relative links cannot be used directly to reference current file
# let current_path = "${builtins.toString ./.}"; in
let current_path = "${config.home.homeDirectory}/piotr_system/home/modules/dolphin"; in
{
  # Holds config created with "Configure dolphin" (icon theme changed by hand)
  # /home/ptryb/.config/dolphinrc
  home.file.".config/dolphinrc".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/dolphinrc";

  # Holds config created with "Configure toolbars"
  # /home/ptryb/.local/share/kxmlgui5/dolphin/dolphinui.rc
  home.file.".local/share/kxmlgui5/dolphin/dolphinui.rc".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/dolphinui.rc";
}
