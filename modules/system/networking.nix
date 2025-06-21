{ config, pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    
    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [ 
        22    # SSH
        80    # HTTP
        443   # HTTPS
        8384  # Syncthing GUI
        22000 # Syncthing sync
      ];
      allowedUDPPorts = [ 
        22000 # Syncthing sync
        21027 # Syncthing discovery
      ];
    };
    
    # DNS configuration
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    
    # Enable wireless support (if needed)
    # wireless.enable = true;
  };
}
