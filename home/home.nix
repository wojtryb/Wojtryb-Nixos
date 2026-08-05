{ config, pkgs, ... }:

{
  imports = [
    ./modules/autostart.nix
    ./modules/firefox.nix
    ./modules/gnome.nix
    ./modules/git.nix
    ./modules/dolphin
    ./modules/krita
    ./modules/vscode
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "wojtryb";
  home.homeDirectory = "/home/wojtryb";

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # home.packages = [ ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;

    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.bash.enable = true;
          
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  home.file.".profile".text = ''
    source "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';

  # Use hardware acceleration while playing videos with mpv
  home.file.".config/mpv/mpv.conf".text = ''hwdec=auto'';

  # desktop files are in
  # ~/.local/share/applications/
  # /run/current-system/sw/share/applications/

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
