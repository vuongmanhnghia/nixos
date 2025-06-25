{ config, pkgs, lib, ... }:
{
  # === GNOME DESKTOP ENVIRONMENT - MODERN CONFIGURATION ===
  services.xserver = {
    enable = true;                      # Enable X11 server for display management
    displayManager.gdm.enable = true;   # Use GDM (GNOME Display Manager)
    desktopManager.gnome.enable = true; # Enable GNOME desktop environment
  };

  # === GNOME APPLICATIONS AND EXTENSIONS ===
  environment.systemPackages = with pkgs; [
    # === GNOME SYSTEM TOOLS ===
    gnome-tweaks              # Advanced GNOME customization tool
    dconf-editor              # Low-level configuration editor
    gnome-shell-extensions    # Shell extension framework
    
    # === ESSENTIAL PRODUCTIVITY EXTENSIONS ===
    gnomeExtensions.appindicator        # System tray support for legacy applications
    gnomeExtensions.dash-to-dock        # Dock at bottom like macOS/Ubuntu
    gnomeExtensions.user-themes         # Custom theme support
    gnomeExtensions.vitals              # System stats in top bar (CPU, memory, network)
    gnomeExtensions.clipboard-indicator # Clipboard history management
    gnomeExtensions.pop-shell           # Tiling window manager functionality
    
    # === MODERN UI/UX ENHANCEMENTS ===
    gnomeExtensions.blur-my-shell       # Blur effects for modern aesthetic
    gnomeExtensions.caffeine            # Prevent system sleep on demand
    gnomeExtensions.gsconnect           # Android phone integration (SMS, notifications)
    gnomeExtensions.just-perfection     # Customize shell elements visibility
    gnomeExtensions.space-bar           # Workspace indicator in top bar
    gnomeExtensions.quick-settings-tweaker # Customize quick settings panel
    gnomeExtensions.tiling-assistant    # Advanced window tiling and snapping
    gnomeExtensions.window-list         # Window list in panel
    gnomeExtensions.workspace-indicator # Workspace switching indicator
    
    # === CORE GNOME APPLICATIONS ===
    nautilus                  # File manager with modern features
    gnome-calculator          # Calculator application
    gnome-calendar            # Calendar with online account integration
    gnome-weather             # Weather application with location services
    gnome-clocks              # World clocks, timers, and alarms
    gnome-system-monitor      # System resource monitor
    gnome-disk-utility        # Disk partitioning and management
    gnome-screenshot          # Screenshot and screen recording tool
    file-roller               # Archive manager for compressed files
    
    # === MEDIA AND DOCUMENT VIEWERS ===
    eog                       # Eye of GNOME image viewer
    evince                    # Document viewer (PDF, PostScript, etc.)
    totem                     # Video player with codec support
    
    # === MODERN FONTS FOR BETTER TYPOGRAPHY ===
    inter                     # Modern UI font with excellent readability
    jetbrains-mono            # Monospace font with programming ligatures
    noto-fonts                # Google's comprehensive Unicode font family
    noto-fonts-emoji          # Emoji rendering support
    liberation_ttf            # Microsoft font replacements
    cascadia-code             # Microsoft's modern coding font
    source-code-pro           # Adobe's monospace font for programming
    
    # === THEMES AND VISUAL CUSTOMIZATION ===
    papirus-icon-theme        # Popular flat icon theme
    tela-icon-theme           # Modern colorful flat icons
    bibata-cursors            # Modern cursor theme with animations
    adwaita-qt                # Qt applications integration with GTK theme
    adwaita-qt6               # Qt6 applications theme consistency
    
    # === SYSTEM UTILITIES ===
    htop                      # Enhanced system monitor
    neofetch                  # System information display with ASCII art
    gparted                   # Advanced partition editor
  ];

  # === EXCLUDED DEFAULT APPLICATIONS ===
  # Remove unnecessary default GNOME applications to reduce bloat
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos              # Photo management (use other alternatives)
    gnome-tour                # Welcome tour (not needed after setup)
    cheese                    # Webcam application
    gnome-music               # Music player (prefer Spotify/other alternatives)
    epiphany                  # GNOME Web browser (prefer Chrome/Firefox)
    geary                     # Email client (prefer web clients)
    gnome-characters          # Character map
    tali                      # Yahtzee game
    iagno                     # Reversi game
    hitori                    # Logic puzzle game
    atomix                    # Molecule puzzle game
    gnome-contacts            # Contacts manager
    gnome-initial-setup       # First-time setup wizard
    gedit                     # Text editor (prefer VS Code/Neovim)
    gnome-maps                # Maps application
    gnome-software            # Software center (use Nix instead)
    simple-scan               # Scanner application
    yelp                      # Help documentation viewer
  ];

  # === GNOME SERVICES AND FUNCTIONALITY ===
  services = {
    gnome = {
      gnome-keyring.enable = true;          # Password and secret management
      evolution-data-server.enable = true;  # Calendar and contacts backend
      gnome-settings-daemon.enable = true;  # Settings and hardware management
      gnome-online-accounts.enable = true;  # Online account integration (Google, etc.)
      localsearch.enable = true;            # File indexing and search (tracker-miners)
      tinysparql.enable = true;             # Search functionality (tracker)
    };
    
    # === AUTO-LOGIN CONFIGURATION ===
    displayManager.autoLogin = {
      enable = true;        # Enable automatic login for convenience
      user = "nagih";       # Auto-login user
    };
    
    # === ADDITIONAL SYSTEM SERVICES ===
    udev.packages = with pkgs; [ gnome-settings-daemon ]; # Hardware detection
    dbus.packages = with pkgs; [ dconf ];                 # Configuration system
    
    # === LOCATION SERVICES ===
    geoclue2.enable = true;  # Location services for weather, timezone
    
    # === PRINTING SUPPORT ===
    printing = {
      enable = true;                                    # Enable CUPS printing
      drivers = with pkgs; [ hplip epson-escpr ];     # Printer drivers
    };
    
    # === PRINTING AND DISCOVERY SERVICES ===
    avahi = {
      enable = true;        # Avahi for network service discovery
      nssmdns4 = true;      # mDNS resolution support
      openFirewall = true;  # Open firewall for printer discovery
    };

    # === FILE SYSTEM AND MEDIA SERVICES ===
    tumbler.enable = true;  # Thumbnail generation for file manager
    gvfs.enable = true;     # Virtual file system support (network, archives)
  };

  # === GDM AND WAYLAND CONFIGURATION ===
  services.xserver.displayManager.gdm = {
    wayland = true;         # Enable Wayland for better performance and security
    autoSuspend = false;    # Disable auto-suspend to prevent login issues
    
    # Advanced GDM settings
    settings = {
      daemon = {
        WaylandEnable = true;           # Force Wayland support
        InitialSetupEnable = false;     # Skip initial setup wizard
      };
    };
  };

  # === NETWORK CONFIGURATION OPTIMIZED FOR GNOME ===
  networking.networkmanager = {
    enable = true;  # Enable NetworkManager for GUI network management
    
    # Wi-Fi performance optimization
    wifi = {
      powersave = false;    # Disable Wi-Fi power saving for better performance
      backend = "iwd";      # Use modern Intel Wi-Fi daemon backend
    };
  };
  
  # === BLUETOOTH CONFIGURATION ===
  hardware.bluetooth = {
    enable = true;          # Enable Bluetooth support
    powerOnBoot = true;     # Automatically enable Bluetooth on startup
    
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";  # Enable all Bluetooth profiles
        Experimental = true;                  # Enable experimental features for better compatibility
      };
    };
  };
  services.blueman.enable = true;  # Bluetooth manager GUI

  # === XDG DESKTOP PORTALS ===
  # Required for proper sandboxed application integration
  xdg.portal = {
    enable = true;  # Enable XDG desktop portals
    
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome  # GNOME-specific portal implementations
      xdg-desktop-portal-gtk    # GTK application portal support
    ];
    config.common.default = "gnome";  # Use GNOME portals by default
  };

  # === POWER MANAGEMENT ===
  services.power-profiles-daemon.enable = true;  # Modern power management (replaces TLP)
  
  # === FIRMWARE AND SOFTWARE UPDATES ===
  services.fwupd.enable = true;     # Firmware update daemon
  services.flatpak.enable = true;   # Flatpak support for additional applications

  # === GNOME-SPECIFIC FONT CONFIGURATION ===
  fonts = {
    enableDefaultPackages = true;  # Enable default font packages
    
    packages = with pkgs; [
      # Modern fonts for GNOME interface
      inter              # Primary UI font
      jetbrains-mono     # Monospace font for terminal/coding
      cascadia-code      # Alternative monospace font
      source-code-pro    # Adobe monospace font
      noto-fonts         # Unicode coverage
      noto-fonts-cjk-sans  # Asian language support
      noto-fonts-emoji   # Emoji rendering
      liberation_ttf     # Microsoft font alternatives
      fira-code          # Programming font with ligatures
      fira-code-symbols  # Additional symbols
      source-han-sans    # Asian sans-serif fonts
      source-han-serif   # Asian serif fonts
      roboto             # Google's Roboto font family
      roboto-mono        # Roboto monospace variant
    ];
    
    # Font rendering configuration
    fontconfig = {
      enable = true;              # Enable fontconfig
      antialias = true;           # Enable font anti-aliasing
      hinting.enable = true;      # Enable font hinting
      hinting.style = "slight";   # Subtle hinting for better readability
      subpixel.rgba = "rgb";      # Subpixel rendering for LCD screens
      
      # Default font stack with fallbacks
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif" ];                              # Serif fonts
        sansSerif = [ "Inter" "Roboto" "Noto Sans" "Source Han Sans" ];          # Sans-serif fonts
        monospace = [ "JetBrains Mono" "Cascadia Code" "Source Code Pro" "Noto Sans Mono" ]; # Monospace fonts
        emoji = [ "Noto Color Emoji" ];                                          # Emoji fonts
      };
    };
  };

  # === SECURITY AND AUTHENTICATION ===
  security.polkit.enable = true;                          # PolicyKit for privilege escalation
  security.pam.services.gdm.enableGnomeKeyring = true;    # GNOME Keyring integration

  # === USER PERMISSIONS FOR FULL GNOME FUNCTIONALITY ===
  users.users.nagih.extraGroups = [ 
    "networkmanager"  # Network configuration
    "wheel"          # sudo privileges
    "audio"          # Audio devices
    "video"          # Video devices and graphics
    "input"          # Input devices (keyboard, mouse)
    "power"          # Power management
    "lp"             # Line printer (printing)
    "scanner"        # Scanner devices
    "dialout"        # Serial devices
    "plugdev"        # Removable/hotplug devices
  ];

  # === DCONF SETTINGS FOR OPTIMIZED GNOME EXPERIENCE ===
  programs.dconf = {
    enable = true;  # Enable dconf configuration system
    
    profiles.user.databases = [{
      settings = {
        # === GNOME INTERFACE OPTIMIZATION ===
        "org/gnome/desktop/interface" = {
          enable-animations = true;                    # Smooth animations
          gtk-theme = "Adwaita";                      # Default GTK theme
          icon-theme = "Papirus";                     # Modern icon theme
          cursor-theme = "Bibata-Modern-Classic";     # Modern cursor theme
          font-name = "Inter 11";                     # UI font
          document-font-name = "Inter 11";            # Document font
          monospace-font-name = "JetBrains Mono 10";  # Terminal/code font
          gtk-enable-primary-paste = false;           # Disable middle-click paste
        };

        # === WINDOW MANAGER OPTIMIZATION ===
        "org/gnome/mutter" = {
          dynamic-workspaces = true;                           # Auto-create/remove workspaces
          workspaces-only-on-primary = false;                 # Workspaces on all monitors
          experimental-features = [ "scale-monitor-framebuffer" ]; # Performance improvements
        };

        # === GNOME SHELL BEHAVIOR ===
        "org/gnome/shell" = {
          enable-hot-corners = false;                                          # Disable hot corners
          app-picker-layout = lib.gvariant.mkEmptyArray lib.gvariant.type.string; # Clean app grid
        };

        # === WINDOW MANAGEMENT PREFERENCES ===
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";  # Window button layout
          focus-mode = "click";                               # Click to focus windows
          resize-with-right-button = true;                    # Right-click resize
        };

        # === POWER MANAGEMENT SETTINGS ===
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";                        # Don't sleep on AC power
          sleep-inactive-battery-type = "suspend";                   # Suspend on battery
          sleep-inactive-battery-timeout = lib.gvariant.mkInt32 1800; # 30 minutes battery timeout
        };

        # === PRIVACY SETTINGS ===
        "org/gnome/desktop/privacy" = {
          disable-camera = false;              # Allow camera access
          disable-microphone = false;          # Allow microphone access
          report-technical-problems = false;   # Disable crash reporting
        };

        # === SEARCH CONFIGURATION ===
        "org/gnome/desktop/search-providers" = {
          disable-external = false;  # Allow external search providers
        };

        # === FILE MANAGER PREFERENCES ===
        "org/gnome/nautilus/preferences" = {
          default-folder-viewer = "list-view";              # Use list view by default
          search-filter-time-type = "last_modified";        # Sort by modification date
          show-hidden-files = false;                        # Hide hidden files
        };

        # === TERMINAL CONFIGURATION ===
        "org/gnome/terminal/legacy/profiles:/:default" = {
          font = "JetBrains Mono 10";  # Terminal font
          use-system-font = false;     # Use custom font
          audible-bell = false;        # Disable terminal bell
        };
      };
    }];
  };

  # === HARDWARE ACCELERATION FOR GRAPHICS PERFORMANCE ===
  hardware.graphics = {
    enable = true;       # Enable graphics acceleration
    enable32Bit = true;  # 32-bit graphics support for gaming/legacy apps
  };
}

