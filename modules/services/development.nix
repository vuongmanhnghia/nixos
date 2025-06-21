{ config, pkgs, ... }:

{
  # Development tools and configurations
  programs.ssh.startAgent = true;
  services.openssh.enable = true;
  
  # Development packages
  environment.systemPackages = with pkgs; [
    # Version control
    git
    
    # Network tools
    curl
    wget
    
    # System monitoring
    htop
    
    # Development utilities
    openssh
  ];
  
  # Enable direnv globally for development environments
  programs.direnv.enable = true;
} 