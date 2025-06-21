{ config, pkgs, inputs ? {}, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system
    ./modules/desktop
  ];
  
  # SSH service configuration
  programs.ssh.startAgent = true;
  services.openssh.enable = true;
    
  # Enable Nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System version
  system.stateVersion = "25.05";

  # User accounts
  users.users = {
    nagih = {
      isNormalUser = true;
      description = "Nagih";
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" "video" ];
      shell = pkgs.bash;
      # CRITICAL: Set initial password for first setup
      initialPassword = "changeme";  # CHANGE THIS AFTER FIRST LOGIN!
    };
    
    # Root user configuration
    # CRITICAL: Keep root enabled for emergency access on fresh installs
    root = {
      # Allow root login for emergency access during setup
      initialPassword = "root";  # CHANGE THIS AFTER SETUP!
      # hashedPassword = "!";  # Enable this ONLY after confirming user access works
    };
  };

  # User groups
  users.groups = {
    docker = {};
  };
}
