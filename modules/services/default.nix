{ config, pkgs, ... }:

{
  imports = [
    ./docker.nix
    ./development.nix
  ];
} 