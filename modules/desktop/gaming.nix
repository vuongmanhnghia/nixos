{ config, pkgs, ... }:

{
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Mở firewall cho Steam Remote Play
    dedicatedServer.openFirewall = true; # Mở firewall cho Steam dedicated servers
  };
  
  # GameMode for better gaming performance
  programs.gamemode.enable = true;
  
  # Additional gaming packages can be added here
  environment.systemPackages = with pkgs; [
    # Gaming utilities
    lutris
    wine
    winetricks
  ];
} 