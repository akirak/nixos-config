{ config, lib, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    overpass
  ];
}
