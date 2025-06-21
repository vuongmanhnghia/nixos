{ config, pkgs, ... }:

{
  # === BOOT CONFIGURATION ===
  boot = {
    loader = {
      # Use systemd-boot as the bootloader (modern UEFI bootloader)
      systemd-boot = {
        enable = true;
        
        # Limit number of boot entries shown in menu (saves /boot space)
        configurationLimit = 5;  # Show only 5 most recent configurations
        
        # Allow editing kernel parameters at boot (security consideration)
        editor = false;  # Set to true if you need to edit boot parameters
        
        # Console resolution mode
        consoleMode = "auto";  # Options: "auto", "max", "0", "1", "2"
      };
      
      # Boot menu timeout before selecting default entry
      timeout = 5;  # 5 seconds (set to null for infinite wait)
      
      # EFI system configuration
      efi = {
        canTouchEfiVariables = true;  # Allow writing to EFI variables
        efiSysMountPoint = "/boot";   # EFI partition mount point (or "/boot/efi")
      };
    };
    
    # Kernel boot parameters for better user experience
    kernelParams = [ "quiet" "splash" ];  # Reduce boot messages, show splash screen
    
    # Enable Plymouth for graphical boot splash screen
    plymouth.enable = true;
    
    # Kernel modules configuration
    kernelModules = [ ];          # Additional kernel modules to load
    extraModulePackages = [ ];    # Extra kernel module packages
  };
  
  # === NIX STORE MANAGEMENT AND OPTIMIZATION ===
  nix = {
    # Automatic garbage collection to save disk space
    gc = {
      automatic = true;                    # Enable automatic cleanup
      dates = "weekly";                    # Run weekly cleanup
      options = "--delete-older-than 14d"; # Keep only last 2 weeks of generations
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ]; # Enable modern Nix features
      auto-optimise-store = true;          # Automatically deduplicate store paths
    };
  };
  
  # Custom cleanup script for manual maintenance
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "cleanup" ''
      # Remove old system profiles older than 7 days
      sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
      # Garbage collect unreferenced store paths
      sudo nix store gc
      # Optimize store by hardlinking identical files
      sudo nix store optimise
    '')
  ];
}
