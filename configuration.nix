{ config, pkgs, inputs ? {}, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/system
    ./modules/desktop
    ./modules/services
  ];
  
  # Unfree nixpkgs
  nixpkgs.config.allowUnfree = true;
    
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
