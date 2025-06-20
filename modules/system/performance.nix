{ config, lib, pkgs, ... }:

{
  # Advanced performance optimizations for NixOS 25.05
  
  # Kernel optimizations
  boot.kernel.sysctl = {
    # Network performance (BBR congestion control)
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.core.rmem_default" = 65536;
    "net.core.wmem_default" = 65536;
    "net.ipv4.tcp_rmem" = "4096 87380 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    
    # Network buffer optimizations
    "net.core.netdev_max_backlog" = 5000;
    "net.core.netdev_budget" = 600;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_mtu_probing" = 1;
    
    # Virtual memory optimizations
    "vm.dirty_ratio" = 5;
    "vm.dirty_background_ratio" = 2;
    "vm.vfs_cache_pressure" = 50;
    "vm.swappiness" = 10;
    "vm.page-cluster" = 0;  # Optimize for SSD
    
    # Memory management for gaming/desktop
    "vm.dirty_expire_centisecs" = 500;
    "vm.dirty_writeback_centisecs" = 100;
    "vm.min_free_kbytes" = 65536;
    
    # File system optimizations
    "fs.inotify.max_user_watches" = 1048576;
    "fs.inotify.max_user_instances" = 1024;
    "fs.file-max" = 2097152;
    
    # Kernel performance
    "kernel.sched_migration_cost_ns" = 5000000;
    "kernel.sched_autogroup_enabled" = 1;  # Enable for desktop responsiveness
    
    # Security with performance balance
    "kernel.yama.ptrace_scope" = 1;
    "kernel.kptr_restrict" = 1;
    
    # Memory overcommit optimization
    "vm.overcommit_memory" = 1;
    "vm.overcommit_ratio" = 50;
    
    # Transparent hugepages for better memory performance
    "vm.nr_hugepages" = 128;
  };
  
  # Additional kernel parameters
  boot.kernelParams = [
    # CPU optimizations
    "mitigations=off"           # Disable CPU vulnerability mitigations for performance (use with caution)
    "processor.max_cstate=1"    # Reduce CPU latency
    "intel_idle.max_cstate=1"   # Intel-specific
    
    # Memory optimizations
    "transparent_hugepage=madvise"
    "hugepagesz=2M"
    "hugepages=128"
    
    # I/O optimizations
    "elevator=none"             # Let scheduler handle I/O
    
    # Graphics and audio
    "snd_hda_intel.power_save=0"  # Disable audio power saving for lower latency
    
    # Performance mode
    "intel_pstate=active"
    "cpuidle.governor=menu"
  ];
  
  # CPU governor optimizations
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "performance";
    powertop.enable = false;  # Disable powertop for performance
  };
  
  # Enhanced Zram configuration
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;  # Reduced for gaming systems
    priority = 10;
  };
  
  # Advanced I/O scheduler optimization
  services.udev.extraRules = ''
    # NVMe drives - use none scheduler (multi-queue)
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/nr_requests}="128"
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/read_ahead_kb}="128"
    
    # SSD drives - use mq-deadline with optimizations
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/nr_requests}="128"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/read_ahead_kb}="128"
    
    # HDD drives - use bfq for better responsiveness
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/nr_requests}="64"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/read_ahead_kb}="4096"
    
    # USB storage optimization
    ACTION=="add|change", SUBSYSTEMS=="usb", ATTR{queue/scheduler}="mq-deadline"
    
    # CPU performance governor
    SUBSYSTEM=="module", ACTION=="add", KERNEL=="acpi_cpufreq", RUN+="${pkgs.bash}/bin/bash -c 'echo performance > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'"
    
    # Network interface optimizations
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth*", RUN+="${pkgs.bash}/bin/bash -c 'echo 1024 > /sys/class/net/%k/queues/rx-0/rps_flow_cnt'"
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="wl*", RUN+="${pkgs.bash}/bin/bash -c 'echo 1024 > /sys/class/net/%k/queues/rx-0/rps_flow_cnt'"
  '';
  
  # Preload commonly used applications for faster startup
  services.preload = {
    enable = true;
  };
  
  # Auto nice daemon for better process prioritization
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };
  
  # Systemd optimizations
  systemd = {
    # Faster boot
    extraConfig = ''
      DefaultTimeoutStopSec=10s
      DefaultTimeoutStartSec=10s
      DefaultDeviceTimeoutSec=10s
    '';
    
    # User service optimizations
    user.extraConfig = ''
      DefaultTimeoutStopSec=10s
      DefaultTimeoutStartSec=10s
    '';
  };
  
  # IRQ balancing for multi-core performance
  services.irqbalance = {
    enable = true;
  };
  
  # Enable multi-threading for Nix builds
  nix.settings = {
    max-jobs = "auto";
    cores = 0;  # Use all available cores
    
    # Build performance optimizations
    builders-use-substitutes = true;
    keep-going = true;
    
    # Experimental features for performance
    experimental-features = [ 
      "nix-command" 
      "flakes" 
      "ca-derivations" 
      "auto-allocate-uids"
    ];
    
    # Auto-optimization
    auto-optimise-store = true;
    
    # System features
    system-features = [ 
      "nixos-test" 
      "benchmark" 
      "big-parallel" 
      "kvm"
    ];
  };
  
  # Performance monitoring tools
  environment.systemPackages = with pkgs; [
    # System monitoring
    htop-vim
    btop
    iotop
    powertop
    
    # Performance tools
    perf-tools
    sysstat
    
    # Network tools
    iperf3
    netdata
    
    # Storage tools
    iozone
    fio
    
    # Memory tools
    memtester
    
    # CPU tools
    stress-ng
    cpufrequtils
    
    # Custom performance script
    (writeShellScriptBin "performance-mode" ''
      #!/usr/bin/env bash
      echo "🚀 Activating Performance Mode..."
      
      # Set CPU governor to performance
      echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
      
      # Disable CPU idle states for minimum latency
      echo 1 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
      
      # Set I/O scheduler to performance
      for disk in /sys/block/sd* /sys/block/nvme*; do
        if [ -e "$disk/queue/scheduler" ]; then
          echo none | sudo tee "$disk/queue/scheduler" 2>/dev/null || echo mq-deadline | sudo tee "$disk/queue/scheduler"
        fi
      done
      
      # Network optimizations
      echo 1 | sudo tee /proc/sys/net/core/busy_poll
      echo 50 | sudo tee /proc/sys/net/core/busy_read
      
      echo "✅ Performance mode activated!"
    '')
    
    (writeShellScriptBin "powersave-mode" ''
      #!/usr/bin/env bash
      echo "🔋 Activating Power Save Mode..."
      
      # Set CPU governor to powersave
      echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
      
      # Enable CPU idle states
      echo 0 | sudo tee /proc/sys/net/core/busy_poll
      
      echo "✅ Power save mode activated!"
    '')
  ];
  
  # Tmpfs for better performance (careful with RAM usage)
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "noatime" "nosuid" "nodev" "size=8G" ];
  };
  
  # Mount options optimization for existing filesystems
  fileSystems = {
    "/" = {
      options = [ "noatime" "compress=zstd" ];
    };
  };
} 