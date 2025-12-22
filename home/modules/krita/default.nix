{ config, pkgs, ... }:

# Path to this position. Relative links cannot be used directly to reference current file
let current_path = "${builtins.toString ./.}"; in
{
  # Copy custom .desktop file with QT_FACTOR_SCALE set to 1
  # Local desktop file overrides global one installed with pkgs.krita
  home.file.".local/share/applications/org.kde.krita.desktop".source = ./org.kde.krita.desktop;

  # Configuration files are symlinked to this repository, making them editable from krita
  home.file.".config/kritarc".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/kritarc";
  home.file.".config/kritadisplayrc".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/kritadisplayrc";
  home.file.".config/kritashortcutsrc".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/kritashortcutsrc";
  home.file.".local/share/krita/krita5.xmlgui".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/krita5.xmlgui";
  home.file.".local/share/krita/input/kritadefault.profile".source = config.lib.file.mkOutOfStoreSymlink "${current_path}/resources/input/kritadefault.profile";

  # Copy krita resources
  # Python plugins are only symlinks to repositories that need to be cloned manually
  home.file.".local/share/krita/color-schemes".source = "${current_path}/resources/color-schemes";
  home.file.".local/share/krita/pykrita".source = "${current_path}/resources/pykrita";
  home.file.".local/share/krita/Krita_5_Starter_pack.bundle".source = "${current_path}/resources/Krita_5_Starter_pack.bundle";
  home.file.".local/share/krita/wojtryb-v6-tilt-rightHand.bundle".source = "${current_path}/resources/wojtryb-v6-tilt-rightHand.bundle";
}