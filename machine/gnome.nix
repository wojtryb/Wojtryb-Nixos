{ config, pkgs, ... }:

{
  # Enable gnome environment
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
  '';
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.gnome.core-apps.enable = true; # most of those are excluded later

  # Exclude many of the gnome packages
  environment.gnome.excludePackages = with pkgs; [
    # # Whitelist of the apps that are not excluded
    # decibels # audio player
    # gnome-font-viewer
    # loupe # image viewer
    # papers # pdf reader
    # showtime # video player (replace with vlc or similar one)
    # adwaita-icon-theme
    # gnome-color-manager
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # gnome-backgrounds # wallpapers
    # nautilus # required for file picking in other apps. TODO: find KDE replacement
    # gnome-control-center # settings - keep for now

    xdg-user-dirs # Home directory localization https://freedesktop.org/wiki/Software/xdg-user-dirs/
    xdg-user-dirs-gtk # Used to create the default bookmarks
    gnome-disk-utility # gparted alternative (?)
    geary # mail
    seahorse # password manager
    gnome-bluetooth
    gnome-tour # have mercy
    gnome-user-docs
    baobab # disk usage
    epiphany # web browser
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-console
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    gnome-connections # remote desktop
    simple-scan
    snapshot # camera
    yelp # gnome help
  ];

  # TODO: find a way to exclude custom package: "nixos-background-info"

  environment.systemPackages = with pkgs; [
    gnome-tweaks # Advanced gnome settings

    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.dash-to-dock
    gnomeExtensions.audio-switch-shortcuts
  ];

  # Enable KDE Connect. Do not use GSConnect (dedicated Gnome implementation) as its not working with dolphin
  programs.kdeconnect = {
    enable = true;
  };
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

}