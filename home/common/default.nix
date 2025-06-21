{ config, pkgs, ... }:

{
  imports = [
    ./neovim
    ./git.nix
    ./shell.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;
} 