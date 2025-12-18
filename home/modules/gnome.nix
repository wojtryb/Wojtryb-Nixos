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
    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive"; # Ask for confirmation to shut down (power button is mapped on keyboard)
      sleep-inactive-ac-type = "nothing"; # Never suspend desktop (Suspend is )
    };
    "org/gnome/desktop/session" = { idle-delay = lib.gvariant.mkUint32 90; }; # Power off screen after that many seconds

    # Mutlitasking
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false; # Disable overview on hover in top-left corner
      color-scheme = "prefer-dark"; # Use dark gnome theme
    };
    "org/gnome/mutter" = {
      edge-tiling = true; # Drag windows to top, left and right to snap them
      dynamic-workspaces = false; # Use fixed number of workspaces
      workspaces-only-on-primary = true; # Workspaces affect only main monitor
    };
    "org/gnome/desktop/wm/preferences" = { num-workspaces = 6; }; # Amount of workspaces
    "org/gnome/shell/app-switcher" = { current-workspace-only = false; }; # Allow cycling between apps on different workspaces

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

    # Keyboard
    "org/gnome/settings-daemon/plugins/media-keys" = {
      previous = [ "<Super>F10" ];
      play = [ "<Super>F11" ];
      next = [ "<Super>F12" ];
      reboot = [ "<Control>PowerOff" ];
    };
    "org/gnome/desktop/wm/keybindings" = { close = [ "<Control>grave" ]; };
    "org/gnome/mutter" = { overlay-key = "Super"; };

    # Graphics Tablet
    "org/gnome/desktop/peripherals/tablets/056a:0317" = {
      mapping = "absolute";
      left-handed = false;
      output = ["" "" ""];
      keep-aspect = true;
    };
    "org/gnome/desktop/peripherals/stylus/51803643" = {
      pressure-curve = [0 26 74 100];    
      button-action = "middle";
      secondary-button-action = "keybinding";
      secondary-button-keybinding = "p";
      tertiary-button-action = "default";
    };

    # Enable gnome extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "just-perfection-desktop@just-perfection"
        # "hidetopbar@mathieu.bidon.ca"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
      ];
    };

    # Extension: Blur my Shell
    "org/gnome/shell/extensions/blur-my-shell/panel" = { blur = false; };
    "org/gnome/shell/extensions/blur-my-shell/overview" = { blur = true; };
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      sigma = 30;
      brightness = 60;
      style-dialogs = 1;
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = { blur = false; };
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      sigma = 36;
      brightness = 1.0;
      opacity = 216;
      dynamic-opacity = false;
      blur-on-overview = false;
      enable-all = false;
      whitelist = [ "org.kde.dolphin" "org.kde.konsole" ];
    };

    # Extension: Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      autohide = false;
      intellihide = false;
      dash-max-icon-size = 64;
      show-favorites = true;
      show-running = true;
      isolate-workspaces = false;
      scroll-to-focused-application = true;
      show-show-apps-button = true;
      show-trash = false;
      show-mounts = false;
      hot-keys = true;
      hotkeys-overlay = false;
      hotkeys-show-dock = true;
      click-action = "cycle-windows";
      shift-click-action = "launch";
      middle-click-action = "launch";
      scroll-action = "do-nothing";
      custom-theme-shrink = false;
      disable-overview-on-startup = false;
      apply-custom-theme = false;
      running-indicator-style = "DOTS";
      custom-theme-running-dots-color = "rgb(61,56,70)";
      custom-theme-running-dots-border-color = "rgb(255,255,255)";
      custom-theme-running-dots-border-width = 6;
      custom-background-color = false;
      transparency-mode = "FIXED";
      background-opacity = 0.8;
    };

    # Extension: Hide Top Bar
    # "org/gnome/shell/extensions/hidetopbar" = {
    #   mouse-sensitive = false;
    #   mouse-sensitive-fullscreen-window = false;
    #   show-in-overview = true;
    #   hot-corner = false;
    #   mouse-triggers-overview = false;
    #   keep-round-corners = false;
    #   enable-intellihide = true;
    #   enable-active-window = false;
    # };

    # Extension: Just Perfection
    "org/gnome/shell/extensions/just-perfection" = {

      # Visibility panel
      panel = false;
      activities-button = true;
      clock-menu = true;
      accessibility-menu = false;
      quick-settings = false;
      calendar = true;
      events-button = false;
      search = false;
      dash = true;
      show-apps-button = true;
      osd = true;
      workspace-popup = true;
      workspace = true;
      workspaces-in-app-grid = true;
      window-preview-close-button = true;
      window-preview-caption = false;
      background-menu = false;
      ripple-box = false;
      window-menu = true;
      window-menu-take-screenshot-button = false;

      # Behavior panel
      workspace-wrap-around = false;
      workspace-peek = true;
      workspace-thumbnail-to-main-view = false;
      window-demands-attention-focus = false;
      window-maximized-on-create = false;
      type-to-search = true;
      workspace-switcher-should-show = true;
      overlay-key = true;
      double-super-to-appgrid = false;
      switcher-popup-delay = false;

      # Customize panel
      accent-color-icon = false;
      top-panel-position = 0;
      clock-menu-position = 0;
      workspace-switcher-size = 12;
      animation = 7;
      notification-banner-position = 1;
    };
  };
}
