{ config, pkgs, ... }:

{
  fileSystems."/mnt/dane" = {
    device = "/dev/disk/by-uuid/97eaa699-568b-4a89-b877-1f84af39ef38";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."/mnt/home" = {
    device = "//192.168.88.23/home";
    fsType = "cifs";
    options = [
      "forceuid"
      "uid=1000"
      "vers=2.0"
      "username=ptryb"
      "password=michal1961"
    ];
  };

  fileSystems."/mnt/music" = {
    device = "//192.168.88.23/music";
    fsType = "cifs";
    options = [
      "forceuid"
      "uid=1000"
      "vers=2.0"
      "username=ptryb"
      "password=michal1961"
    ];
  };

  fileSystems."/mnt/video" = {
    device = "//192.168.88.23/video";
    fsType = "cifs";
    options = [
      "forceuid"
      "uid=1000"
      "vers=2.0"
      "username=ptryb"
      "password=michal1961"
    ];
  };

  fileSystems."/mnt/zdjecia" = {
    device = "//192.168.88.23/zdjecia";
    fsType = "cifs";
    options = [
      "forceuid"
      "uid=1000"
      "vers=2.0"
      "username=ptryb"
      "password=michal1961"
    ];
  };
}
