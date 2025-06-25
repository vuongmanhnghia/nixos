{ config, pkgs, ... }:

{
  # === STEAM GAMING PLATFORM ===
  programs.steam = {
    enable = true;                    # Enable Steam gaming platform
    remotePlay.openFirewall = true;   # Allow Steam Remote Play through firewall
    gamescopeSession.enable = true;   # Enable Gamescope compositor session for Steam Deck-like experience
  };
  
  # === GAMING PERFORMANCE OPTIMIZATION ===
  programs.gamemode.enable = true;    # Enable GameMode for automatic CPU/GPU optimization during gaming

  # === GAMING SOFTWARE PACKAGES ===
  environment.systemPackages = with pkgs; [
    # Performance monitoring and overlay tools
    mangohud     # Performance overlay for games (FPS, GPU/CPU usage, temperatures)
    gamescope    # Micro-compositor for better gaming performance and compatibility
    
    # Windows compatibility layer for non-Steam games
    wineWowPackages.stable  # Wine for running Windows applications and games
    winetricks              # Helper script for installing Windows dependencies in Wine
    lutris                  # Game launcher for managing Wine games and emulators
    
    # Steam-specific tools
    protonup-qt   # GUI tool for managing Proton versions (Steam's Wine fork)
    steam-run     # Utility for running non-Steam applications with Steam's runtime
  ];

  # === GRAPHICS SUPPORT FOR GAMING ===
  hardware.graphics.enable32Bit = true;  # Enable 32-bit graphics libraries (required for many games)
  
  # === GAMING CONTROLLER SUPPORT ===
  # udev rules for proper controller recognition and permissions
  services.udev.extraRules = ''
    # PlayStation 4/5 Controllers - DualShock 4 and DualSense support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", MODE="0664", GROUP="wheel"
    
    # Xbox Controllers - Xbox One and Series X/S controller support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", MODE="0664", GROUP="wheel"
    
    # Nintendo Switch Pro Controller support
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0664", GROUP="wheel"
  '';

  # === USER PERMISSIONS ===
  users.users.nagih.extraGroups = [ "gamemode" ];  # Add user to gamemode group for performance optimizations
} 