{ config, pkgs, ... }:

{
  # User accounts
  users.users = {
    nagih = {
      isNormalUser = true;
      description = "Nagih";
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" "video" ];
      shell = pkgs.bash;
    };
  };
  
  # Root user configuration
  users.users.root = {
    hashedPassword = "!"; # Disable root login
  };

  # User groups
  users.groups = {
    docker = {};
  };
} 