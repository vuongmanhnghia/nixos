{ config, pkgs, ... }:

{
  # === BASIC SECURITY CONFIGURATION ===
  security = {
    # Enable PolicyKit for desktop privilege management (required for GNOME)
    polkit.enable = true;
    
    # Require password for sudo commands (security best practice)
    sudo.wheelNeedsPassword = true;
  };
  
  # === SSH SECURITY HARDENING ===
  services.openssh = {
    enable = true;  # Enable SSH daemon for remote access
    settings = {
      PasswordAuthentication = false;   # Disable password login (key-only authentication)
      PermitRootLogin = "no";           # Disable direct root login for security
    };
  };
  
  # === FIREWALL CONFIGURATION ===
  networking.firewall = {
    enable = true;                    # Enable firewall protection
    allowedTCPPorts = [ 22 ];         # Allow SSH access (port 22)
    allowedUDPPorts = [ ];            # No UDP ports open by default
  };
} 