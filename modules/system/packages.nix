{ config, pkgs, ... }:

{
  # Essential system packages
  environment.systemPackages = with pkgs; [
    # Network tools
    curl
    wget
    
    # Version control
    git
    
    # Remote access
    openssh
    
    # System monitoring
    htop
  ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
} 