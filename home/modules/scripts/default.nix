{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.runCommand "my-scripts" {} ''
      mkdir -p $out/bin
      cp ${./scripts}/* $out/bin/
      chmod +x $out/bin/*
    '')
    pkgs.ffmpeg
    pkgs.python3
  ];
}
