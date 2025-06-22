{ config, pkgs, ... }:

{
  # === KERNEL OPTIMIZATIONS - NIXOS 25.05 ===
  # Centralized kernel sysctl configurations to avoid conflicts
  
  boot.kernel.sysctl = {
    # === MEMORY MANAGEMENT ===
    "vm.swappiness" = 10;                    # Reduce swap usage
    "vm.max_map_count" = 2147483642;         # For games and containers
    "vm.overcommit_memory" = 1;              # Optimistic memory allocation
    
    # === FILESYSTEM ===
    "fs.inotify.max_user_watches" = 1048576; # For file watching (IDEs, etc.)
    "fs.file-max" = 2097152;                 # Increase file descriptor limit
    
    # === NETWORK OPTIMIZATIONS ===
    # Buffer sizes for audio/gaming/streaming
    "net.core.rmem_default" = 262144;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_default" = 262144;
    "net.core.wmem_max" = 16777216;
    "net.core.netdev_max_backlog" = 5000;
    
    # TCP optimizations for low latency
    "net.ipv4.tcp_timestamps" = 0;          # Reduce network latency
    "net.ipv4.tcp_sack" = 1;                # Selective acknowledgment
    "net.ipv4.tcp_fack" = 1;                # Forward acknowledgment
    "net.ipv4.ip_forward" = 1;              # Enable IP forwarding (for Docker)
    
    # Bridge networking (for Docker)
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.bridge.bridge-nf-call-ip6tables" = 1;
    
    # === SYSTEM STABILITY ===
    "kernel.panic" = 10;                     # Reboot after 10 seconds on panic
    "kernel.panic_on_oops" = 1;              # Panic on kernel oops
    
    # === SECURITY ===
    "kernel.dmesg_restrict" = 1;             # Restrict dmesg access
    "kernel.kptr_restrict" = 2;              # Hide kernel pointers
  };
  
  # === KERNEL MODULES ===
  boot.kernelModules = [
    # Audio optimization
    "snd-seq"
    "snd-rawmidi"
    
    # Gaming optimization
    "uinput"  # For controllers
    
    # Networking
    "br_netfilter"  # For Docker
  ];
  
  # === KERNEL PARAMETERS ===
  boot.kernelParams = [
    # Memory optimization
    "transparent_hugepage=madvise"
    
    # Audio optimization
    "snd-hda-intel.power_save=0"
    
    # Gaming optimization
    "mitigations=off"  # Disable CPU mitigations for performance (use with caution)
  ];
} 