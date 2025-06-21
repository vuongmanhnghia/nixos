{ config, pkgs, ... }:
{
  # Security configuration
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    
    # Sudo configuration
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
    
    # PAM configuration - DISABLED U2F for fresh installs
    # pam.services = {
    #   login.u2fAuth = true;
    #   sudo.u2fAuth = true;
    # };
  };

  # Enable automatic security updates
  system.autoUpgrade = {
    enable = false;
    allowReboot = false;
  };
}
