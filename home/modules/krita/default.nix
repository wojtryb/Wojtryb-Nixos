{ config, pkgs, ... }:

{
  home.file.".config/kritarc".source = ./kritarc;
  home.file.".config/kritadisplayrc".source = ./kritadisplayrc;
  home.file.".config/kritashortcutsrc".source = ./kritashortcutsrc;

  home.file.".local/share/krita/color-schemes".source = ./resources/color-schemes;
  home.file.".local/share/krita/pykrita".source = ./resources/pykrita;
  home.file.".local/share/krita/Krita_5_Starter_pack.bundle".source = ./resources/Krita_5_Starter_pack.bundle;
  home.file.".local/share/krita/wojtryb-v6-tilt-rightHand.bundle".source = ./resources/wojtryb-v6-tilt-rightHand.bundle;
}