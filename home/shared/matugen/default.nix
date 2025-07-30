# matugen/default.nix - File chính
{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/config.nix
    ./modules/aliases.nix
    ./modules/service.nix
    ./modules/auto-wallpaper.nix
  ];

  # Install matugen package
  home.packages = with pkgs; [
    matugen
  ];
}