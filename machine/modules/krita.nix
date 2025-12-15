{ config, pkgs, ... }:

let
  desktopFile = pkgs.makeDesktopItem {
    name = "krita_stable";
    desktopName = "Krita (Stable)";
    genericName = "2D Painting program";
    exec = "env QT_SCALE_FACTOR=1 krita";
    icon = "krita";
    comment = "krita";
    categories = [ "Graphics" ];
    terminal = false;
    startupNotify = true;
    type= "Application";
    prefersNonDefaultGPU=true;
    mimeTypes = [ "application/x-krita" ];
    startupWMClass="Krita";
  };

in {
  environment.systemPackages = with pkgs; [
    pkgs.krita
    desktopFile
  ];
}