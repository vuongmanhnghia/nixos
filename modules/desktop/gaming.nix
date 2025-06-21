{ config, pkgs, ... }:

{
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;       # Open firewall for Steam Remote Play
    dedicatedServer.openFirewall = true;  # Open firewall for Steam dedicated servers
  };
  
  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    # Steam is handled by programs.steam above
    # Add other gaming tools here if needed
  ];
} 