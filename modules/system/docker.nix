{ config, pkgs, ... }:

{
  # === DOCKER CONFIGURATION - NIXOS 25.05 ===
  
  # Enable Docker virtualisation
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
    
    # Storage driver optimization
    storageDriver = "overlay2";
    
    # Enable experimental features
    daemon.settings = {
      experimental = true;
      # Performance optimizations
      "max-concurrent-downloads" = 10;
      "max-concurrent-uploads" = 10;
      "max-download-attempts" = 5;
      
      # Logging configuration
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
  };
  
  # Docker Compose - modern version
  virtualisation.docker.enableOnBoot = true;
  
  # User groups for Docker access
  users.extraGroups.docker = {};
  
  # Essential Docker packages
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-credential-helpers
    dive  # Docker image analyzer
    ctop  # Container top
  ];
  
  # Firewall rules for Docker
  networking.firewall.trustedInterfaces = [ "docker0" ];
  
  # Enable container runtime optimizations
  systemd.services.docker = {
    serviceConfig = {
      # Restart policy
      Restart = "always";
      RestartSec = "10s";
      
      # Performance optimizations
      LimitNOFILE = 1048576;
      LimitNPROC = 1048576;
    };
  };
} 