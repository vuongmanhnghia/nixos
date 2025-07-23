{ config, pkgs, ... }:
{
  networking = {
    # === SYSTEM IDENTIFICATION ===
    hostName = "nixos";             # System hostname for network identification
    networkmanager.enable = true;   # Enable NetworkManager for easy network management
    
    # === FIREWALL CONFIGURATION ===
    firewall = {
      enable = true;                 # Enable firewall protection
      allowedTCPPorts = [ 
        22   # SSH - remote access
        80   # HTTP - web server
        443  # HTTPS - secure web server
      ];
      allowedUDPPorts = [ ];         # No UDP ports opened by default
      # Allow Tailscale traffic
      trustedInterfaces = [ "tailscale0" ];
    };
    
    # === DNS CONFIGURATION ===
    nameservers = [ 
      "8.8.8.8"   # Google DNS primary
      "8.8.4.4"   # Google DNS secondary
    ];
    
    # === WIRELESS CONFIGURATION ===
    # wireless.enable = true;        # Uncomment for wireless support without NetworkManager
  };

  # === VPN SERVICES ===
  services.tailscale = {
    enable = true;  # Enable Tailscale VPN mesh network
    useRoutingFeatures = "client";  # Enable routing features for client mode
    openFirewall = true;  # Automatically open required firewall ports
    # Allow user to control Tailscale without sudo
    extraUpFlags = [ "--operator=nagih" ];
  };
}
