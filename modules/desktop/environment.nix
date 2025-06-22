{ config, lib, pkgs, ... }:

let
  # Auto-detect hardware capabilities
  hasNvidia = builtins.elem "nvidia" config.services.xserver.videoDrivers;
  isIntel = config.hardware.cpu.intel.updateMicrocode or false;
  
  # Session type detection
  preferWayland = true; # Default to Wayland for modern experience
  
in {
  # Centralized Environment Variables - NixOS 25.05 Optimized
  environment.sessionVariables = {
    # === DISPLAY SERVER CONFIG ===
    # Smart Wayland/X11 selection
    NIXOS_OZONE_WL = if preferWayland then "1" else "0";
    MOZ_ENABLE_WAYLAND = if preferWayland then "1" else "0";
    
    # GTK/Qt backend selection - conditional on session type
    GDK_BACKEND = lib.mkDefault (if preferWayland then "wayland,x11" else "x11");
    QT_QPA_PLATFORM = lib.mkDefault (if preferWayland then "wayland;xcb" else "xcb");
    
    # === HARDWARE ACCELERATION ===
    # NVIDIA specific settings
    GBM_BACKEND = lib.mkIf hasNvidia "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = lib.mkIf hasNvidia "nvidia";
    LIBVA_DRIVER_NAME = if hasNvidia then "nvidia" else (lib.mkDefault "iHD");
    
    # Vulkan configuration
    VK_DRIVER_FILES = lib.mkIf hasNvidia "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    
    # === GRAPHICS OPTIMIZATIONS ===
    # Variable refresh rate and performance
    __GL_VRR_ALLOWED = lib.mkIf hasNvidia "1";
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    __GL_MaxFramesAllowed = lib.mkIf hasNvidia "1";
    
    # Wayland specific fixes
    WLR_NO_HARDWARE_CURSORS = lib.mkIf (hasNvidia && preferWayland) "1";
    
    # === DISPLAY SCALING ===
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    
    # === GNOME OPTIMIZATIONS ===
    GNOME_SHELL_SLOWDOWN_FACTOR = "0.5";
    GSK_RENDERER = "ngl"; # New GL renderer for better performance
    
    # === CURSOR CONFIGURATION ===
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    
    # === INPUT METHODS ===
    # Consolidated input method settings
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    FCITX_ADDON_DIRS = "${pkgs.fcitx5}/share/fcitx5/addon:${pkgs.fcitx5-unikey}/share/fcitx5/addon:${pkgs.fcitx5-bamboo}/share/fcitx5/addon";
    
    # === GAMING OPTIMIZATIONS ===
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    STEAM_RUNTIME = "0";
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    
    # === PERFORMANCE TWEAKS ===
    # Audio latency optimization
    PULSE_LATENCY_MSEC = "30";
    
    # Memory management
    GC_INITIAL_HEAP_SIZE = "1G";
    
    # === APPLICATION DEFAULTS ===
    # Core applications
    BROWSER = "google-chrome";
    EDITOR = "nvim";
    TERMINAL = "gnome-terminal";
    
    # File manager
    FILE_MANAGER = "nautilus";
  };

  # Additional system-wide environment optimizations
  environment.variables = {
    # Path optimizations
    PATH = [ 
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
      "$HOME/.npm-global/bin"
    ];
  };

  # Session-specific overrides for problematic applications
  environment.etc."profile.d/app-overrides.sh".text = ''
    # VSCode - Force X11 for stability
    alias code='env NIXOS_OZONE_WL=0 GDK_BACKEND=x11 code'
    alias cursor='env NIXOS_OZONE_WL=0 GDK_BACKEND=x11 cursor'
    
    # Discord - Better Wayland support in newer versions
    alias discord='env NIXOS_OZONE_WL=1 discord'
    
    # Steam - Ensure proper environment
    alias steam='env STEAM_FORCE_DESKTOPUI_SCALING=1 steam'
  '';
} 