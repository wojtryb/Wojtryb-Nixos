{
  lib,
  config,
  pkgs,
  ...
}:
{

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
    QT_SCALE_FACTOR = 1.5;
    # QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
    # theme = {
    #   name = "adwaita-dark";
    #   package = pkgs.adwaita-qt6;
    # };
    # theme = {
    #   name = "Sweet";
    #   package = pkgs.sweet;
    # };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
      size = 48;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  # home.sessionVariables.GTK_THEME = "adwaita-dark";
  # home.sessionVariables.QT_SCALE_FACTOR = 1.5;
  
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "orange";
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "ctrl:nocaps" ];
    };
  };

  }
