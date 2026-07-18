{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "Wojciech Trybus";
      user.email = "wojtryb@gmail.com";
      init.defaultBranch = "main";
    };
  };
}