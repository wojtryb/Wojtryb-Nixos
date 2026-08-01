{ config, pkgs, ... }:

# Path to this position. Relative links cannot be used directly to reference current file
let current_path = "${builtins.toString ./.}"; in
{
  # Local desktop file overrides global one installed from pkgs
  home.file.".local/share/applications/davinci-resolve-studio.desktop".source = ./davinci-resolve-studio.desktop;
}