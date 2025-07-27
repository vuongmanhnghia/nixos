{ config, pkgs, ... }:

{
  # === BASIC HYPRLAND SETUP ===
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # === ESSENTIAL PACKAGES ===
  environment.systemPackages = with pkgs; [
    # Terminal (sử dụng lại ghostty đã có)
    ghostty
    
    # Basic launcher 
    rofi-wayland
    
    # Essential Wayland tools
    wl-clipboard    # Clipboard
    grim           # Screenshots
    slurp          # Screen selection
    
    # === PHASE 1: CORE COMPONENTS ===
    # Status bar & UI
    waybar         # Status bar
    
    # File manager
    nemo           # File manager (theo ViegPhunt)
    
    # Wallpaper & Visual
    swww           # Wallpaper daemon
    hyprshot       # Advanced screenshot tool
    cava           # Audio visualizer
    
    # System utilities
    brightnessctl  # Brightness control
    pavucontrol    # Audio control GUI
    
    # Clipboard manager
    cliphist       # Clipboard history
    
    # === INPUT METHOD (TIẾNG VIỆT) ===
    fcitx5                # Input method framework
    fcitx5-gtk           # GTK integration
    libsForQt5.fcitx5-qt # Qt5 integration
    fcitx5-configtool    # Configuration tool
    fcitx5-unikey        # Vietnamese input method (Unikey)
    
    # === FONTS ===
    jetbrains-mono       # Main font
    nerd-fonts.jetbrains-mono  # Nerd font variant
    
    # === PHASE 2: ENHANCED UI & NOTIFICATIONS ===
    # Notifications
    swaynotificationcenter  # Modern notification center
    
    # Logout menu
    wlogout              # Logout menu with themes
    
    # Enhanced theming
    papirus-icon-theme   # Icon theme
    whitesur-cursors     # Cursor theme
    catppuccin-gtk       # GTK theme
    catppuccin-cursors.mochaDark  # Cursor theme variant
    
    # Additional utilities
    playerctl           # Media control
    networkmanagerapplet # Network applet
    blueman             # Bluetooth manager
    oh-my-posh          # Enhanced shell prompt
    fastfetch           # System info display
    
    # === PHASE 3: COMPLETE VIEGPHUNT INTEGRATION ===
    # Qt theme tools
    libsForQt5.qt5ct     # Qt5 configuration tool
    qt6ct               # Qt6 configuration tool
    
    # Additional utilities
    gnome-characters    # Character map
    vips                # Image processing library
    nwg-look            # GTK theme switcher
    
    # Development tools
    cheese              # Webcam application
    loupe               # Image viewer
    celluloid           # Video player
    gnome-text-editor   # Text editor
    obs-studio          # Screen recording
    ffmpeg              # Media processing
    
    # === AUDIO SUPPORT ===
    pulseaudio          # Audio server for SwayNC controls
    
    # === NOTIFICATION SUPPORT ===
    libnotify           # Notification testing
  ];

  # === DISPLAY MANAGER ===
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = false;  # Disable GNOME
    displayManager.gdm.enable = false;    # Disable GDM
  };
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # === BASIC WAYLAND ENVIRONMENT ===
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";  # For Electron apps
  };

  # === INPUT METHOD SETUP ===
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-unikey         # Vietnamese input method
      fcitx5-gtk            # GTK integration
      libsForQt5.fcitx5-qt  # Qt5 integration
    ];
  };

  # === BASIC SERVICES ===
  security.polkit.enable = true;
  
  # Enable gvfs for file manager
  services.gvfs.enable = true;
} 