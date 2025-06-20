{ config, pkgs, inputs, ... }:

{
  # Gaming-specific configuration with advanced optimizations
  
  # GameMode for performance optimization
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        inhibit_screensaver = 1;
        desiredgov = "performance";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
  
  # Steam configuration (consolidated from multiple places)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    
    # Steam extra compatibility tools
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    
    # Steam package with additional features
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };
  
  # Gaming packages and tools
  environment.systemPackages = with pkgs; [
    # Proton and Wine tools
    protonup-qt
    winetricks
    protontricks
    
    # Game launchers
    lutris
    heroic
    
    # Performance monitoring and tools
    mangohud
    gamemode
    goverlay  # GUI for MangoHud
    
    # Controller support
    antimicrox
    
    # Wine for non-Steam games (latest stable)
    wineWowPackages.waylandFull
    
    # System monitoring for gaming
    htop-vim
    nvtopPackages.full
    
    # Audio tools for gaming
    pavucontrol
    pulseaudio
    
    # Network tools for gaming
    mtr
    iperf3
    
    # Emulation (commented out - uncomment if needed)
    # retroarch
    # dolphin-emu
    # pcsx2
    # rpcs3
  ];
  
  # Enable controller and Steam hardware support
  hardware.steam-hardware.enable = true;
  
  # Gaming-optimized firewall rules
  networking.firewall = {
    allowedTCPPorts = [ 
      27015       # Steam game servers
      27016       # Steam game servers  
      27017       # Steam game servers
      27018       # Steam game servers
      27019       # Steam game servers
      27020       # Steam game servers
      27036       # Steam Remote Play
      27037       # Steam Remote Play
      8080        # Common game port
      3478        # Nintendo Switch Online
      6667        # IRC (for some games)
    ];
    allowedUDPPorts = [ 
      27000 27001 27002 27003 27004 27005 # Steam client
      27015 27016 27017 27018 27019 27020 # Steam game servers
      27031 27036  # Steam
      7777 7778    # Common game ports
      3478 3479    # Nintendo Switch Online  
      53           # DNS for games
    ];
    
    # Allow local network gaming
    allowedTCPPortRanges = [
      { from = 1024; to = 65535; } # High ports for P2P gaming
    ];
    allowedUDPPortRanges = [
      { from = 1024; to = 65535; } # High ports for P2P gaming  
    ];
  };
  
  # Real-time scheduling for better gaming performance
  security.rtkit.enable = true;
  
  # Gaming-optimized kernel parameters
  boot.kernel.sysctl = {
    # Increase memory map limit for games
    "vm.max_map_count" = 2147483642;
    
    # Optimize for gaming workloads
    "kernel.sched_latency_ns" = 1000000;        # 1ms
    "kernel.sched_min_granularity_ns" = 100000; # 0.1ms
    "kernel.sched_wakeup_granularity_ns" = 250000; # 0.25ms
    
    # Reduce input lag
    "kernel.sched_rt_runtime_us" = 950000;
    "kernel.sched_rt_period_us" = 1000000;
  };
  
  # Gaming-specific environment variables
  environment.sessionVariables = {
    # Enable MangoHud for all games
    MANGOHUD = "1";
    
    # Optimize for gaming
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_PATH = "/tmp/nvidia-shader-cache";
    
    # Proton/Wine optimizations
    DXVK_HUD = "fps,memory,gpuload";
    WINEDEBUG = "-all";
    
    # Steam optimizations
    STEAM_FRAME_FORCE_CLOSE = "1";
  };
  
  # Udev rules for gaming peripherals
  services.udev.extraRules = ''
    # Xbox controllers
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="02ea", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="02fd", MODE="0666"
    
    # PlayStation controllers  
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
    
    # Nintendo Pro Controller
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0666"
    
    # Set CPU governor to performance for gaming
    SUBSYSTEM=="module", ACTION=="add", KERNEL=="acpi_cpufreq", RUN+="${pkgs.bash}/bin/bash -c 'echo performance > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'"
  '';
} 