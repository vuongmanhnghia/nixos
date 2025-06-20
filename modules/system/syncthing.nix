{ config, lib, pkgs, ... }:

{
  # Syncthing file synchronization service
  services.syncthing = {
    enable = true;
    user = "nagih";
    dataDir = "/home/nagih/.syncthing";
    configDir = "/home/nagih/.config/syncthing";
    
    # Auto-upgrade Syncthing
    package = pkgs.syncthing;
    
    # Open firewall ports
    openDefaultPorts = true;
    
    # GUI settings
    guiAddress = "127.0.0.1:8384";
    
    # Override specific device and folder configurations if needed
    overrideDevices = true;
    overrideFolders = true;
  };

  # Firewall configuration for Syncthing
  networking.firewall = {
    allowedTCPPorts = [ 
      8384  # Syncthing GUI
      22000 # Syncthing sync protocol
    ];
    allowedUDPPorts = [ 
      22000 # Syncthing sync protocol
      21027 # Syncthing discovery
    ];
  };

  # Enable auto-start for user session
  systemd.user.services.syncthing = {
    environment = {
      STNODEFAULTFOLDER = "true"; # Don't create default folder
    };
  };
} 