{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "trybstation";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.xserver.enable = true;

  # Enable gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.desktopManager.gnome.extraGSettingsOverrides = ''
  #   [org.gnome.mutter]
  #   experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
  # '';

  services.gnome.core-apps.enable = true; # most of those are excluded later
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [

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
    # pkgs.xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # pkgs.xdg-user-dirs-gtk # Used to create the default bookmarks
    # pkgs.gnome-backgrounds # wallpapers

    pkgs.gnome-disk-utility
    pkgs.geary # mail
    pkgs.seahorse # password manager
    # nixos-background-info
    pkgs.gnome-bluetooth
    pkgs.gnome-control-center # settings - keep for now
    pkgs.gnome-tour # GNOME Shell detects the .desktop file on first log-in.
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
    # pkgs.nautilus
    pkgs.gnome-connections # remote desktop
    pkgs.simple-scan
    pkgs.snapshot # camera
    pkgs.yelp # gnome help
  ];

  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  # Fix missing libs for gnome utilities like choosing color or picking a file
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  services.displayManager.autoLogin.enable  = true;
  services.displayManager.autoLogin.user = "wojtryb";

  console.keyMap = "pl2";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Disable touchpad
  services.libinput.enable = false;

  users.users.wojtryb = {
    isNormalUser = true;
    description = "wojtryb";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # kdePackages.kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kdePackages.qtsvg
    # libsForQt5.qt5ct
    # libsForQt5.qtstyleplugin-kvantum
    # kdePackages.qt6ct
    # adwaita-qt
    adwaita-qt6
    # pkgs.sweet
    # sweet-nova
      
    kdePackages.kate
    kdePackages.konsole
    
    pkgs.krita
    pkgs.vscode
    pkgs.blender
    pkgs.spotify
    
    appimage-run 
      
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    
    pkgs.candy-icons
    
    gnome-tweaks

    pkgs.rar
    pkgs.unzip
    pkgs.zip
  ];

  # xdg.portal.lxqt.enable = true;
  # xdg.portal.lxqt.styles = [
  #   pkgs.sweet
  #   pkgs.sweet-nova
  # ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

# targets.genericLinux.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.firefox.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
