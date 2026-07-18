{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./gnome.nix
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

  # Fix missing libs for gnome utilities like choosing color or picking a file
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];

  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "wojtryb";
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

  # quiet boot...
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    # "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "boot.shell_on_fail"
  ];

  console.keyMap = "pl2";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Touchpad
  services.libinput.enable = true;

  users.users.wojtryb = {
    isNormalUser = true;
    description = "wojtryb";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # File manager dolphin
    kdePackages.dolphin
    kdePackages.kio # needed since 25.11
    kdePackages.kio-fuse # to mount remote filesystems via FUSE
    kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    kdePackages.karchive # to open .zip files directly in dolphin
    kdePackages.ark # to compress files into .zip from dolphin
    kdePackages.qtsvg

    # Core apps
    kdePackages.kate # Simple code editor
    kdePackages.konsole # Terminal
    pkgs-unstable.krita # 2D Painting
    inkscape # 2D Vector editing
    # (blender.override { # 3D modeling
    #   cudaSupport = true;
    # })
    pkgs-unstable.blender
    vscode # Advanced code editor
    spotify # Music
    firefox # Web
    obs-studio # Recording

    # Programming packages
    python312
    python312Packages.pip

    # Utilities
    killall
    htop
    screenfetch
    rar
    appimage-run # Running appimage files

    # Theming
    adwaita-qt6 # Theme for qt apps that looks like gnome theme 
    candy-icons # Icons for app-selection and dolphin 
  ];

  # Enable nvidia driver
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Remap some keyboard keys
  # keyd is used instead of kanata which caused cursor glitches for krita color selector popup
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            # keyd list-keys
            "delete" = "print";
            "home" = "delete";
            "pageup" =  "noop";
            "pagedown" =  "home";
            "rightcontrol" =  "rightmouse";
            "mute" =  "power";
            "capslock" = "noop";
            "f10" = "previoussong";
            "f11" = "playpause";
            "f12" = "nextsong";
          };
        };
      };
    };
  };

  # Do not change even if the nixos gets updated.
  system.stateVersion = "25.11";

}
