{ config, pkgs, ... }:

{
  # === USER ACCOUNT CONFIGURATION ===
  users.users = {
    nagih = {
      isNormalUser = true;      # Standard user account (not system user)
      description = "Nagih";    # User description for display
      # User groups for system permissions
      extraGroups = [ 
        "networkmanager"  # Network configuration access
        "wheel"          # sudo privileges 
        "docker"         # Docker daemon access
        "audio"          # Audio devices access
        "video"          # Video devices and GPU access
      ];
      shell = pkgs.zsh;       # Default shell (zsh)
    };
  };

  # === SYSTEM GROUPS ===
  users.groups = {
    docker = {};  # Docker group for container management permissions
  };
}
