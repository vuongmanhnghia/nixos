{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./security.nix
    ./audio.nix
    ./hardware.nix
    ./performance.nix
    ./syncthing.nix
  ];
}
