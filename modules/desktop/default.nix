{ config, pkgs, ... }:
{
  imports = [
    ./xserver.nix
    ./nvidia.nix
    ./gnome.nix
    ./input-methods.nix
    ./audio.nix
    ./fonts.nix
    ./gaming.nix
  ];
}
