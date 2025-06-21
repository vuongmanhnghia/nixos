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
}
