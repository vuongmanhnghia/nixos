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

  # User groups
  users.groups = {
    docker = {};
  };
}
