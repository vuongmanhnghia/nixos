{ config, pkgs, ... }:
{
  imports = [
    # Core environment configuration (must be first)
    ./environment.nix
    
    # Audio system
    ./audio.nix
    
    # Desktop environments
    ./gnome.nix
    ./xserver.nix
    
    # Hardware specific
    ./nvidia.nix
    
    # Gaming and entertainment
    ./gaming.nix
    
    # Input methods
    ./input-methods.nix
    
    # Font configuration
    ./fonts.nix
    
    # Docker configuration
    ../system/docker.nix
    
    # System optimizations
    ../system/kernel-optimization.nix
  ];
}
