{ config, pkgs, ... }:

{
  # Firewall configuration
  networking.firewall = {
    allowedTCPPorts = [ 
      22    # SSH
      8384  # Syncthing GUI
      22000 # Syncthing sync
    ];
    allowedUDPPorts = [ 
      22000 # Syncthing sync
      21027 # Syncthing discovery
    ];
  };
} 