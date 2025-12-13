{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "wojtryb";
      user.email = "wojtryb@gmail.com";
      init.defaultBranch = "main";
    };
  };
}