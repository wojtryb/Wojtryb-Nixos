{ config, pkgs, ... }:

{
  # Copy custom .desktop file with QT_FACTOR_SCALE set to 1
  # Local desktop file overrides global one installed with pkgs.krita
  home.file.".local/share/applications/org.kde.krita.desktop".source = ./org.kde.krita.desktop;

  # Copy krita configuration files
  home.file.".config/kritarc".source = ./kritarc;
  home.file.".config/kritadisplayrc".source = ./kritadisplayrc;
  home.file.".config/kritashortcutsrc".source = ./kritashortcutsrc;

  # Copy krita resources
  # Python plugins are only symlinks to repositories that need to be cloned manually
  home.file.".local/share/krita/color-schemes".source = ./resources/color-schemes;
  home.file.".local/share/krita/pykrita".source = ./resources/pykrita;
  home.file.".local/share/krita/input/kritadefault.profile".source = ./resources/input/kritadefault.profile;
  home.file.".local/share/krita/Krita_5_Starter_pack.bundle".source = ./resources/Krita_5_Starter_pack.bundle;
  home.file.".local/share/krita/wojtryb-v6-tilt-rightHand.bundle".source = ./resources/wojtryb-v6-tilt-rightHand.bundle;
}