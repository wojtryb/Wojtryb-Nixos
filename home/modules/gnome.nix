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
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
      size = 48;
    };
  };
  
  dconf.enable = true;
  dconf.settings = {
    # "org/gnome/desktop/input-sources" = { xkb-options = [ "ctrl:nocaps" ]; };

    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive"; # Ask for confirmation to shut down (power button is mapped on keyboard)
      sleep-inactive-ac-type = "nothing"; # Never suspend desktop (Suspend is )
    };
    "org/gnome/desktop/session" = { "idle-delay" = 180; }; # NOT WORKING

    # Mutlitasking
    "org/gnome/desktop/interface" = {
      "enable-hot-corners" = false; # Disable overview on hover in top-left corner
      "color-scheme" = "prefer-dark"; # Use dark gnome theme
    };
    "org/gnome/mutter" = {
      "edge-tiling" = true; # Drag windows to top, left and right to snap them
      "dynamic-workspaces" = false; # Use fixed number of workspaces
      "workspaces-only-on-primary" = true; # Workspaces affect only main monitor
    };
    "org/gnome/desktop/wm/preferences" = { "num-workspaces" = 6; }; # Amount of workspaces
    "org/gnome/shell/app-switcher" = { "current-workspace-only" = false; }; # Allow cycling between apps on different workspaces

    # Appearance
    "org/gnome/desktop/interface" = { accent-color = "orange"; };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#241f31";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      primary-color = "#241f31";
    };

    # Mouse and Touchpad
    "org/gnome/desktop/peripherals/mouse" = {
      left-handed = false;
      speed = -0.22;
      accel-profile = "default";
      natural-scroll = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = { send-events = "disabled"; };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      next = [ "<Shift>AudioPlay" ];
      previous = [ "<Shift><Control>AudioPlay" ];
      reboot = [ "<Control>PowerOff" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Control>grave" ];

    };
    "org/gnome/mutter" = { overlay-key = "Super"; };
  };
}
