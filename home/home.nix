{ config, pkgs, ... }:

{
  imports = [
    ./modules/firefox.nix
    ./modules/gnome.nix
    ./modules/git.nix
  ];

  home.username = "wojtryb";
  home.homeDirectory = "/home/wojtryb";

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # home.packages = [ ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.bash.enable = true;
  # programs.bash = {
  #     enable = true;
  #     bashrcExtra = ''
  #       export QT_STYLE_OVERRIDE=adwaita-dark
  #       export QT_SCALE_FACTOR=1.5
  #     '';
  # };
          
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
home.file.".profile".text = ''
  # -*- mode: sh -*-
  source "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
'';
  # ${sessionVarsStr}
  # ${cfg.profileExtra}

  # home.sessionVariables = {
  #   ASD = "DUPA";
  # };

  # desktop files are in
  # ~/.local/share/applications/
  # /run/current-system/sw/share/applications/

  # xdg.desktopEntries = {
  #   dupa = {
  #     name = "DUPA";
  #     genericName = "Web Browser";
  #     exec = "firefox %U";
  #     terminal = false;
  #     categories = [ "Network" "WebBrowser" ];
  #     mimeType = [ "text/html" "text/xml" ];
  #   };
  # };

  # programs.krita.overrideAttrs = (e: rec {
  #   # Add arguments to the .desktop entry
  #   desktopItem = e.desktopItem.override (d: {
  #     exec = "${d.exec} --example-one --example-two";
  #   });

  #   # Update the install script to use the new .desktop entry
  #   installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
  # });

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
