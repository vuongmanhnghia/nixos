{ config, pkgs, inputs, system, lib, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    
    # System modules
    ../../modules/system
    ../../modules/desktop
    
    # Host-specific overrides
    ./nvidia.nix
    ./gaming.nix
  ];
  
  # System identification
  networking.hostName = "desktop";
  system.stateVersion = "25.05";
  
  # User accounts
  users.users = {
    nagih = {
      isNormalUser = true;
      description = "Nagih";
      extraGroups = [ 
        "networkmanager" 
        "wheel" 
        "docker" 
        "audio" 
        "video" 
        "input"
        "gamemode"
      ];
      shell = pkgs.bash;
      initialPassword = "nagih123";
    };
  };
  
  # Security: Disable root login
  # users.users.root.hashedPassword = "!";  # Commented out temporarily
  
  # EMERGENCY: Temporarily allow root login for system recovery
  # Remove this after confirming nagih user works
  users.users.root.initialPassword = "emergency123";
  
  # System-wide packages (minimal, most should go in home-manager)
  environment.systemPackages = with pkgs; [
    # Essential system tools
    curl
    wget
    git
    openssh
    htop
    
    # Hardware tools
    pciutils
    usbutils
    lshw
    
    # Network tools
    networkmanager
    networkmanager-openvpn
    
    # Archive tools
    unzip
    zip
    p7zip
    
    # File management
    file
    tree
    fd
    ripgrep
  ];
  
  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      
      # Binary caches
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-gaming.cachix.org"
        "https://nix-community.cachix.org"
      ];
      
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = lib.mkForce "--delete-older-than 30d";
    };
    
    # Keep build dependencies for development
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable automatic updates for security
  system.autoUpgrade = {
    enable = false; # Disable for flake-based system
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
  };
} 
