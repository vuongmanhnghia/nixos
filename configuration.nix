{ config, pkgs, inputs ? {}, lib, ... }:

{
  # Import all configuration modules
  imports = [
    ./hardware-configuration.nix # Hardware-specific configuration (auto-generated)
    ./system                     # System-level configurations (boot, users, networking, etc.)
    ./desktop                    # Desktop environment configurations (GNOME, audio, graphics)
    ./programs                   # Application configurations (gaming, development, multimedia)
  ];
  
  # SSH configuration
  programs.ssh.startAgent = true; # Start SSH agent for key management
  services.openssh.enable = true; # Enable SSH daemon for remote access

  # Disable nscd
  services.nscd.enable = false;

  # Sử dụng systemd-resolved thay thế
  services.resolved.enable = true;

  # Disable NSS modules để tránh conflict
  system.nssModules = lib.mkForce [];
    
  # Enable Nix flakes and new command syntax
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System version - should match your NixOS release
  system.stateVersion = "25.05";
}
