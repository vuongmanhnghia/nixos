# waybar/modules/default.nix - Main modules entry point
{ config, pkgs, lib, ... }:

{
  imports = [
    ./system.nix
    ./hyprland.nix
    ./audio.nix
    ./network.nix
    ./media.nix
    ./custom.nix
    ./separators.nix
    ./groups.nix
    ./other.nix
  ];

  # Module configuration options
  options.waybar.modules = {
    system = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "System-related modules (battery, temperature, etc.)";
    };
    
    hyprland = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Hyprland-specific modules";
    };
    
    audio = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Audio-related modules";
    };
    
    network = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Network-related modules";
    };
    
    media = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Media player modules";
    };
    
    custom = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Custom modules";
    };
    
    separators = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Separator modules";
    };
    
    groups = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Module groups";
    };
    
    other = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Other misc modules";
    };
  };
}