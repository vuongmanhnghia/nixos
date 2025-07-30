# matugen/default.nix - File chính
{ config, pkgs, lib, ... }:

{
  imports = [
    ./config.nix
    ./aliases.nix
    ./service.nix
    ./auto-wallpaper.nix
  ];

  # Install matugen package
  home.packages = with pkgs; [
    matugen
  ];
}