{ config, pkgs, ... }:

{
  # Optimized boot configuration for performance and speed
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        
        # Limit boot entries for faster menu loading
        configurationLimit = 7;  # Keep only 7 most recent generations
        
        # Disable editor for security and faster boot
        editor = false;
        
        # Optimal console resolution
        consoleMode = "max";  # Use maximum resolution
        
        # Faster menu timeout
        memtest86.enable = false;  # Disable memtest for faster boot
      };
      
      # Reduce timeout for faster boot
      timeout = 1;  # 1 second only
      
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    
    # Performance-oriented kernel parameters
    kernelParams = [ 
      # Debug boot issues - TEMPORARY
      "debug"
      "initcall_debug"
      "loglevel=7"  # Maximum verbosity
      "rd.debug"
      "rd.udev.debug"
      
      # Silent boot for faster startup - COMMENTED OUT FOR DEBUGGING
      # "quiet"
      # "splash"
      # "loglevel=3"
      # "systemd.show_status=auto"
      # "rd.udev.log_level=3"
      
      # Memory and CPU optimizations during boot
      "boot=silent"
      
      # Faster I/O during boot
      # "elevator=none"
    ];
    
    # Enable Plymouth for smooth boot animation
    plymouth = {
      enable = true;
      theme = "breeze";  # Clean theme
    };
    
    # Kernel modules optimization
    kernelModules = [ ];
    extraModulePackages = [ ];
    
    # Boot optimization
    tmp.cleanOnBoot = true;     # Clean /tmp on boot
    
    # Faster initrd
    initrd = {
      verbose = true;           # Enable verbose for debugging boot issues
      systemd.enable = false;   # Disable systemd in initrd temporarily - use traditional initrd
      
      # Optimize initrd modules - MUST MATCH hardware-configuration.nix
      availableKernelModules = [
        "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"  # Added missing "vmd" and "usbhid"
      ];
      
      # Network in initrd (if needed)
      network.enable = false;
    };
  };
  
  # Advanced Nix store optimization
  nix = {
    settings = {
      # Experimental features for better performance
      experimental-features = [ 
        "nix-command" 
        "flakes" 
        "ca-derivations"
        "auto-allocate-uids"
        "configurable-impure-env"
      ];
      
      # Build optimization
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
      
      # Faster substitution
      builders-use-substitutes = true;
      substitute = true;
      
      # Trusted users for faster builds
      trusted-users = [ "root" "nagih" ];
      
      # Keep derivations and outputs for development
      keep-derivations = true;
      keep-outputs = true;
      
      # Faster builds
      sandbox = true;
      restrict-eval = false;
      
      # Binary cache optimization
      connect-timeout = 5;
      stalled-download-timeout = 300;
      
      # System features
      system-features = [ 
        "nixos-test" 
        "benchmark" 
        "big-parallel" 
        "kvm"
        "recursive-nix"
      ];
    };
    
    # Aggressive garbage collection for performance
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";  # Keep only 1 week
      persistent = true;
    };
    
    # Optimize store periodically
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    
    # Extra Nix options for performance
    extraOptions = ''
      # Build performance
      keep-outputs = true
      keep-derivations = true
      
      # Network timeouts
      connect-timeout = 5
      stalled-download-timeout = 300
      
      # Parallel processing
      max-silent-time = 3600
      build-timeout = 7200
      
      # Faster evaluation
      eval-cache = true
      
      # Memory optimization
      min-free = ${toString (1 * 1024 * 1024 * 1024)}  # 1GB min free
      max-free = ${toString (8 * 1024 * 1024 * 1024)}  # 8GB max free
    '';
  };
  
  # System optimization tools
  environment.systemPackages = with pkgs; [
    # Boot and system tools
    systemd
    usbutils
    pciutils
    dmidecode
    
    # Cleanup and maintenance scripts
    (writeShellScriptBin "system-cleanup" ''
      #!/usr/bin/env bash
      echo "🧹 Starting system cleanup..."
      
      # Clean nix store
      echo "Cleaning Nix store..."
      sudo nix-collect-garbage -d
      sudo nix store optimise
      
      # Clean systemd journals
      echo "Cleaning systemd journals..."
      sudo journalctl --vacuum-time=7d
      sudo journalctl --vacuum-size=100M
      
      # Clean temporary files
      echo "Cleaning temporary files..."
      sudo rm -rf /tmp/*
      sudo rm -rf /var/tmp/*
      
      # Clean package caches
      echo "Cleaning package caches..."
      sudo rm -rf /root/.cache/*
      rm -rf ~/.cache/*
      
      # Clean old generations
      echo "Cleaning old system generations..."
      sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
      
      echo "✅ System cleanup completed!"
    '')
    
    (writeShellScriptBin "boot-analyze" ''
      #!/usr/bin/env bash
      echo "📊 Boot Performance Analysis"
      echo "=========================="
      
      echo "Boot time:"
      systemd-analyze
      echo ""
      
      echo "Critical chain:"
      systemd-analyze critical-chain
      echo ""
      
      echo "Slowest services:"
      systemd-analyze blame | head -10
      echo ""
      
      echo "Boot plot (SVG):"
      echo "Run: systemd-analyze plot > /tmp/boot-plot.svg"
    '')
    
    (writeShellScriptBin "optimize-system" ''
      #!/usr/bin/env bash
      echo "⚡ Optimizing system performance..."
      
      # Set CPU governor to performance
      echo "Setting CPU governor to performance..."
      echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
      
      # Optimize I/O schedulers
      echo "Optimizing I/O schedulers..."
      for disk in /sys/block/*/queue/scheduler; do
        if [[ -e $disk ]]; then
          if [[ $disk == *nvme* ]]; then
            echo none | sudo tee "$disk" 2>/dev/null
          else
            echo mq-deadline | sudo tee "$disk" 2>/dev/null
          fi
        fi
      done
      
      # Clear caches
      echo "Clearing system caches..."
      sync
      echo 3 | sudo tee /proc/sys/vm/drop_caches
      
      # Optimize Nix store
      echo "Optimizing Nix store..."
      nix store optimise &
      
      echo "✅ System optimization completed!"
    '')
  ];
  
  # Systemd optimizations for faster boot
  systemd = {
    # Reduce default timeouts
    extraConfig = ''
      DefaultTimeoutStartSec=10s
      DefaultTimeoutStopSec=5s
      DefaultDeviceTimeoutSec=10s
      DefaultTimeoutAbortSec=10s
    '';
    
    # User session optimizations
    user.extraConfig = ''
      DefaultTimeoutStartSec=10s
      DefaultTimeoutStopSec=5s
    '';
    
    # Disable unnecessary services for faster boot
    services = {
      # Disable if not needed
      systemd-random-seed.enable = false;
      
      # Optimize NetworkManager startup
      NetworkManager-wait-online.enable = false;
    };
  };
  
  # Security with performance balance
  security = {
    # Disable audit for performance (enable if needed for compliance)
    audit.enable = false;
    
    # AppArmor (lighter than SELinux)
    apparmor.enable = false;  # Disable for maximum performance
  };
}
