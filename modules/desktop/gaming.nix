{ config, pkgs, ... }:

{
  # === STEAM CONFIGURATION - NIXOS 25.05 OPTIMIZED ===
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;       # Open firewall for Steam Remote Play
    dedicatedServer.openFirewall = true;  # Open firewall for Steam dedicated servers
    gamescopeSession.enable = true;       # Enable GameScope session for Wayland
    localNetworkGameTransfers.openFirewall = true; # Enable local network game transfers
    
    # Optimized Steam package with essential dependencies
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        # Essential X11/Wayland compatibility
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        
        # Audio libraries
        libpulseaudio
        libvorbis
        
        # Graphics libraries
        libpng
        
        # System libraries
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        
        # GUI frameworks
        gtk3
        gtk2
        atk
        cairo
        gdk-pixbuf
        glib
        
        # Font and text rendering
        freetype
        fontconfig
        
        # System integration
        dbus
        nspr
        nss
        expat
        systemd
        
        # Application indicators
        libappindicator-gtk3
        libdbusmenu
        libindicator-gtk3
      ];
    };
  };
  
  # === GAMEMODE CONFIGURATION ===
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
  
  # === GAMING PACKAGES ===
  environment.systemPackages = with pkgs; [
    # Performance monitoring and optimization
    mangohud          # Performance overlay with Wayland support
    gamescope         # Wayland compositor for gaming
    
    # Wine and compatibility layers
    wineWowPackages.stable
    winetricks
    lutris
    
    # Game launchers and tools
    protonup-qt      # Proton version management
    steam-run        # Run non-Steam games with Steam runtime
    
    # System libraries that games might need
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
    
    # Audio support
    alsa-lib
    alsa-plugins
    
    # Network tools
    curl
    
    # System utilities for gaming
    pciutils
    usbutils
    
    # GUI libraries for compatibility
    gtk3
    gtk2
    glib
    cairo
    pango
    gdk-pixbuf
    atk
    
    # Notification support
    libnotify
  ];
  
  # === HARDWARE OPTIMIZATIONS ===
  # Enable 32-bit support for games
  hardware.graphics.enable32Bit = true;
  
  # Audio support for 32-bit games
  services.pulseaudio.support32Bit = true;
  
  # === UDEV RULES FOR GAMING DEVICES ===
  services.udev.extraRules = ''
    # Steam Controller
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0664", GROUP="wheel"
    
    # PS4 Controller
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0664", GROUP="wheel"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0664", GROUP="wheel"
    
    # PS5 Controller (DualSense)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0664", GROUP="wheel"
    
    # Xbox Controllers
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="02d1", MODE="0664", GROUP="wheel"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="02dd", MODE="0664", GROUP="wheel"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="0b12", MODE="0664", GROUP="wheel"
    
    # Nintendo Switch Pro Controller
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0664", GROUP="wheel"
    
    # Generic gaming device permissions
    SUBSYSTEM=="input", GROUP="input", MODE="0664"
    SUBSYSTEM=="usb", ENV{ID_INPUT_JOYSTICK}=="1", MODE="0664", GROUP="wheel"
    KERNEL=="js[0-9]*", MODE="0664", GROUP="wheel"
    KERNEL=="event[0-9]*", MODE="0664", GROUP="input"
  '';
  
  # === USER GROUPS ===
  users.users.nagih.extraGroups = [ "gamemode" "input" ];
  
  # === SYSTEMD OPTIMIZATIONS ===
  systemd.extraConfig = ''
    DefaultCPUAccounting=yes
    DefaultMemoryAccounting=yes
    DefaultTasksAccounting=yes
  '';
  
  # GameScope session optimization
  systemd.user.services.gamescope-session = {
    environment = {
      # Wayland optimizations for GameScope
      WLR_RENDERER = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
} 