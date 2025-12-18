{ config, pkgs, ... }:

{
  # Enable gnome environment
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.displayManager.gdm.enable = true;
  services.gnome.core-apps.enable = false; # most of those are excluded later
  services.desktopManager.gnome.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
  '';

  # Exclude many of the gnome packages
  environment.gnome.excludePackages = with pkgs; [
    # # Whitelist of the apps that are not excluded
    # pkgs.decibels # audio player
    # pkgs.gnome-font-viewer
    # pkgs.loupe # image viewer
    # pkgs.papers # pdf reader
    # pkgs.showtime # video player (replace with vlc or similar one)
    # pkgs.adwaita-icon-theme
    # pkgs.gnome-color-manager
    # pkgs.glib # for gsettings program
    # pkgs.gnome-menus
    # pkgs.gtk3.out # for gtk-launch program
    # pkgs.gnome-backgrounds # wallpapers
    # pkgs.nautilus # required for file picking in other apps. TODO: find KDE replacement
    # pkgs.gnome-control-center # settings - keep for now

    pkgs.xdg-user-dirs # Home directory localization https://freedesktop.org/wiki/Software/xdg-user-dirs/
    pkgs.xdg-user-dirs-gtk # Used to create the default bookmarks
    pkgs.gnome-disk-utility # gparted alternative (?)
    pkgs.geary # mail
    pkgs.seahorse # password manager
    pkgs.gnome-bluetooth
    pkgs.gnome-tour # have mercy
    pkgs.gnome-user-docs
    pkgs.baobab # disk usage
    pkgs.epiphany # web browser
    pkgs.gnome-text-editor
    pkgs.gnome-calculator
    pkgs.gnome-calendar
    pkgs.gnome-characters
    pkgs.gnome-clocks
    pkgs.gnome-console
    pkgs.gnome-contacts
    pkgs.gnome-logs
    pkgs.gnome-maps
    pkgs.gnome-music
    pkgs.gnome-system-monitor
    pkgs.gnome-weather
    pkgs.gnome-connections # remote desktop
    pkgs.simple-scan
    pkgs.snapshot # camera
    pkgs.yelp # gnome help
  ];

  # TODO: find a way to exclude custom package: "nixos-background-info"

  environment.systemPackages = with pkgs; [
    gnome-tweaks # Advanced gnome settings

    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.dash-to-dock
  ];

}