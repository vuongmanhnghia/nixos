{ config, pkgs, lib, ... }:
{
  networking = {
    hostName = lib.mkDefault "nixos";
    networkmanager.enable = true;
    
    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ ];
    };
    
    # DNS configuration
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    
    # Enable wireless support (if needed)
    # wireless.enable = true;
  };
}
