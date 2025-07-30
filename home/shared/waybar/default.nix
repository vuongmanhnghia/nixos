# waybar.nix - Main configuration file
{ config, pkgs, lib, ... }:

{
  # Import all waybar modules
  imports = [
    ./settings.nix
    ./styles.nix
    ./modules
  ];

  # Enable Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
    # Settings will be imported from ./settings.nix
    settings = config.waybar.customSettings;
    
    # Styles will be imported from ./styles.nix  
    style = config.waybar.customStyles;
  };
}