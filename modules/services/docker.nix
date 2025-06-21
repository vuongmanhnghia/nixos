{ config, pkgs, ... }:

{
  # Docker configuration
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  
  # Docker-related packages
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
} 