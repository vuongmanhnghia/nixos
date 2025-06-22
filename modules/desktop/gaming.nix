{ config, pkgs, ... }:

{
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;       # Open firewall for Steam Remote Play
    dedicatedServer.openFirewall = true;  # Open firewall for Steam dedicated servers
    gamescopeSession.enable = true;       # Enable GameScope session
    localNetworkGameTransfers.openFirewall = true; # Enable local network game transfers
    
    # Force native runtime to avoid sandbox issues
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
        gtk3
        gtk2
        atk
        cairo
        gdk-pixbuf
        glib
        freetype
        fontconfig
        dbus
        nspr
        nss
        expat
        systemd
        libappindicator-gtk3
        libdbusmenu
        libindicator-gtk3
      ];
    };
  };
  
  # Enable GameMode for better gaming performance
  programs.gamemode.enable = true;
  
  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    # Steam is handled by programs.steam above
    # Gaming utilities
    mangohud          # Performance overlay
    gamemode          # Gaming performance optimization
    gamescope         # Wayland compositor for gaming
    
    # Wine and compatibility layers
    wineWowPackages.stable
    winetricks
    lutris
    
    # Additional libraries that Steam might need
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
    
    # Vulkan and graphics
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    
    # Audio
    alsa-lib
    alsa-plugins
    
    # Networking
    curl
    
    # System utilities
    pciutils
    usbutils
    
    # GUI libraries for Steam
    gtk3
    gtk2
    glib
    cairo
    pango
    gdk-pixbuf
    atk
  ];
  
  # Enable 32-bit support for Steam
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;
  
  # Environment variables for Steam
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # Force Steam to use native runtime
    STEAM_RUNTIME = "0";
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "1";
    # Fix scaling issues
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    GDK_SCALE = "1";
    QT_SCALE_FACTOR = "1";
  };
} 