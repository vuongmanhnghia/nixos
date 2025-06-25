{ config, pkgs, ... }:

{
  # System-level configuration modules
  imports = [
    ./boot.nix       # Bootloader and kernel configuration
    ./users.nix      # User accounts and groups
    ./networking.nix # Network, firewall, and DNS settings
    ./locale.nix     # Timezone, locale, and keyboard layout
    ./packages.nix   # Essential system packages and C++ development tools
    ./security.nix   # Security policies and configurations
  ];
} 