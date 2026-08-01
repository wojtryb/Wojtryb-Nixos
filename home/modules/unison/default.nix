{ config, pkgs, ... }:

{
  home.file.".unison/zdjecia.prf".source = ./zdjecia.prf;
  home.file.".unison/Filmy_Rodzina.prf".source = ./Filmy_Rodzina.prf;
}
