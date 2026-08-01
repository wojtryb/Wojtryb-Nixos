{ config, pkgs, ... }:

{
  imports = [
    # ./modules/autostart.nix
    ./modules/firefox.nix
    ./modules/gnome.nix
    ./modules/git.nix
    ./modules/dolphin
    # ./modules/krita
    ./modules/resolve
    ./modules/vscode
    ./modules/unison
    ./modules/scripts
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "ptryb";
  home.homeDirectory = "/home/ptryb";

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

  # desktop files are in
  # ~/.local/share/applications/
  # /run/current-system/sw/share/applications/

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
