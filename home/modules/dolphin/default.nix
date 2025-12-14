{ config, pkgs, ... }:

{
  # Holds config created with "Configure dolphin" (icon theme changed by hand)
  # /home/wojtryb/.config/dolphinrc
  home.file.".config/dolphinrc".source = ./dolphinrc;

  # Holds config created with "Configure toolbars"
  # /home/wojtryb/.local/share/kxmlgui5/dolphin/dolphinui.rc
  home.file.".local/share/kxmlgui5/dolphin/dolphinui.rc".source = ./dolphinui.rc;
}
