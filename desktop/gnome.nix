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
    # gnomeExtensions.appindicator        # System tray support for legacy applications
    gnomeExtensions.dash-to-dock        # Dock at bottom like macOS/Ubuntu
    gnomeExtensions.user-themes         # Custom theme support
    gnomeExtensions.clipboard-indicator # Clipboard history management
    gnomeExtensions.hidden-input-method-panel # Input method panel for Fcitx5 on Wayland (kimpanel protocol)
    
    # === MODERN UI/UX ENHANCEMENTS ===
    gnomeExtensions.caffeine            # Prevent system sleep on demand
    gnomeExtensions.just-perfection     # Customize shell elements visibility
    gnomeExtensions.night-theme-switcher # Auto dark/light theme switching
    gnomeExtensions.rounded-corners # Modern rounded corners aesthetic
    gnomeExtensions.blur-my-shell       # Advanced blur and transparency effects
    
    # === CORE GNOME APPLICATIONS ===
    nautilus                  # File manager with modern features
    gnome-calendar            # Calendar with online account integration
    gnome-disk-utility        # Disk partitioning and management
    file-roller               # Archive manager for compressed files
    
    # === MODERN APP REPLACEMENTS ===
    snapshot                  # Modern screenshot tool (replaces gnome-screenshot)
    loupe                     # Modern image viewer (replaces eog)
    gnome-text-editor         # Modern text editor for GNOME
    
    # === NEW PRODUCTIVITY APPS ===
    papers                    # Modern GNOME document viewer
    video-trimmer             # Simple video trimming tool
    
    # === DEVELOPMENT TOOLS ===
    gitg                      # GNOME Git repository viewer
    
    # === MEDIA AND DOCUMENT VIEWERS ===
    evince                    # Document viewer (PDF, PostScript, etc.)
    totem                     # Video player with codec support
    
    # === ESSENTIAL FONTS ===
    inter                     # Modern UI font with excellent readability
    jetbrains-mono            # Monospace font with programming ligatures
    noto-fonts                # Google's comprehensive Unicode font family
    noto-fonts-emoji          # Emoji rendering support
    liberation_ttf            # Microsoft font replacements
    
    # === SIMPLE THEMES ===
    papirus-icon-theme        # Popular flat icon theme
    adwaita-qt                # Qt applications integration with GTK theme
    adwaita-qt6               # Qt6 applications theme consistency
    
    # === X11 FALLBACK APP LAUNCHERS ===
    # Simple commands for apps that work better with X11
    (writeShellScriptBin "cursor-x11" ''
      #!/usr/bin/env bash
      # Launch Cursor with X11 backend silently
      unset NIXOS_OZONE_WL
      exec env ELECTRON_OZONE_PLATFORM_HINT=x11 cursor "$@" >/dev/null 2>&1 &
      disown
    '')
    
    (writeShellScriptBin "discord-x11" ''
      #!/usr/bin/env bash
      # Launch Discord with X11 backend silently
      unset NIXOS_OZONE_WL
      exec env ELECTRON_OZONE_PLATFORM_HINT=x11 discord "$@" >/dev/null 2>&1 &
      disown
    '')
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
      gnome-settings-daemon.enable = true;  # Settings and hardware management
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
    dbus.packages = with pkgs; [ 
      dconf                      # Configuration system
      # ENHANCED DBUS PORTAL INTEGRATION
      xdg-desktop-portal-gnome   # GNOME portal D-Bus services
      xdg-desktop-portal-gtk     # GTK portal D-Bus services  
      gnome-session             # Session management services
      gnome-shell               # Shell integration services
    ];
    
    # === LOCATION SERVICES ===
    geoclue2.enable = true;  # Location services for weather, timezone
    
    # === ENHANCED PRINTING SUPPORT ===
    printing = {
      enable = true;                                    # Enable CUPS printing
      drivers = with pkgs; [ 
        hplip                      # HP printers
        epson-escpr               # Epson printers
        canon-cups-ufr2           # Canon printers
        samsung-unified-linux-driver # Samsung printers
      ];
      browsing = true;             # Enable printer discovery
      defaultShared = false;       # Don't share printers by default (security)
    };
    
    # === ENHANCED PRINTING AND DISCOVERY SERVICES ===
    avahi = {
      enable = true;        # Avahi for network service discovery
      nssmdns4 = true;      # mDNS resolution support
      openFirewall = true;  # Open firewall for printer discovery
      
      # SAFE OPTIMIZATION: Enhanced publishing
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };

    # === FILE SYSTEM AND MEDIA SERVICES ===
    tumbler.enable = true;  # Thumbnail generation for file manager
    gvfs.enable = true;     # Virtual file system support (network, archives)
    
    # === JOURNAL SIZE OPTIMIZATION ===
    journald.extraConfig = ''
      SystemMaxUse=500M
      SystemMaxFileSize=50M
      RuntimeMaxUse=100M
      MaxRetentionSec=1month
    '';
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
        DefaultSession = "gnome-wayland"; # Force Wayland session as default
        AutomaticLoginEnable = true;    # Enable automatic login integration
      };
    };
  };

  # === WAYLAND ENVIRONMENT OPTIMIZATIONS ===
  environment.sessionVariables = {
    # Enable Wayland for Electron applications (VS Code, Discord, Spotify)
    NIXOS_OZONE_WL = "1";
    
    # Enable Wayland for Qt applications
    QT_QPA_PLATFORM = "wayland";
    
    # Better Wayland scaling
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    
    # Wayland-specific optimizations
    WAYLAND_DISPLAY = "wayland-0";
    XDG_SESSION_TYPE = "wayland";
    
    # === ENVIRONMENT CLEANUP (SAFE OPTIMIZATION) ===
    EDITOR = "nvim";                    # Default editor
    BROWSER = "firefox";          # Default browser
    TERMINAL = "gnome-terminal";        # Default terminal
    
    # Performance (safe):
    MOZ_USE_XINPUT2 = "1";             # Better touch support
    XCURSOR_SIZE = "24";               # Consistent cursor size
    
    # === XDG PORTAL ENVIRONMENT ENHANCEMENTS ===
    XDG_CURRENT_DESKTOP = "GNOME";     # Explicit desktop identification for portals
    XDG_SESSION_DESKTOP = "gnome";     # Session type specification for portal routing
    
    # Portal-specific optimizations for better app integration
    GTK_USE_PORTAL = "1";              # Force GTK applications to use portal system
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

  # === ENHANCED XDG DESKTOP PORTALS ===
  # Advanced portal configuration for optimal app integration
  xdg.portal = {
    enable = true;
    
    # Comprehensive portal support for all application types
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome  # GNOME-specific portal implementations
      xdg-desktop-portal-gtk    # GTK application portal support
    ];
    
    # === EXPLICIT PORTAL ROUTING FOR RELIABILITY ===
    config = {
      # Default routing for all desktop environments
      common = {
        default = [ "gnome" "gtk" ];                                        # Primary portal preference order
        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" "gtk" ];     # File picker dialogs
        "org.freedesktop.impl.portal.AppChooser" = [ "gnome" "gtk" ];      # Application chooser dialogs
        "org.freedesktop.impl.portal.Print" = [ "gnome" "gtk" ];           # Print dialogs
        "org.freedesktop.impl.portal.Notification" = [ "gnome" ];          # System notifications
        "org.freedesktop.impl.portal.Inhibit" = [ "gnome" ];               # System inhibition (sleep/screensaver)
        "org.freedesktop.impl.portal.Access" = [ "gnome" ];                # File access permissions
        "org.freedesktop.impl.portal.Account" = [ "gnome" ];               # Account information
        "org.freedesktop.impl.portal.Email" = [ "gnome" ];                 # Email composition
        "org.freedesktop.impl.portal.DynamicLauncher" = [ "gnome" ];       # Dynamic app launching
        "org.freedesktop.impl.portal.Realtime" = [ "gnome" ];              # Realtime scheduling
        "org.freedesktop.impl.portal.NetworkMonitor" = [ "gnome" ];        # Network monitoring
        "org.freedesktop.impl.portal.ProxyResolver" = [ "gnome" ];         # Proxy resolution
        "org.freedesktop.impl.portal.Wallpaper" = [ "gnome" ];             # Wallpaper setting
      };
      
      # GNOME-specific optimizations for best integration
      gnome = {
        default = [ "gnome" "gtk" ];                                        # GNOME session defaults
        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];           # Native GNOME file dialogs
        "org.freedesktop.impl.portal.AppChooser" = [ "gnome" ];            # Native GNOME app chooser
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];            # GNOME screenshot integration
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];            # GNOME screen sharing/recording
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];         # Remote desktop support
      };
    };
    
    # === AUTOMATIC CONFIGURATION PACKAGES ===
    configPackages = with pkgs; [
      gnome-session              # GNOME session management integration
      gnome-shell               # GNOME shell environment detection
    ];
  };

  # === POWER MANAGEMENT ===
  services.power-profiles-daemon.enable = true;  # Modern power management (replaces TLP)
  
  # === FIRMWARE AND SOFTWARE UPDATES ===
  services.fwupd.enable = true;     # Firmware update daemon
  services.flatpak.enable = true;   # Flatpak support for additional applications

  # === GNOME-SPECIFIC FONT PACKAGES (UI focused) ===
  fonts = {
    packages = with pkgs; [
      # UI and theme specific fonts
      inter              # Primary UI font
      roboto             # Google's Roboto font family
    ];
  };

  # === ENHANCED USER PERMISSIONS FOR FULL GNOME FUNCTIONALITY ===
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
    
    # === SAFE ADDITIONS for better hardware support ===
    "storage"        # Storage device access
    "optical"        # CD/DVD access
    "kvm"           # Virtualization (if needed)
  ];

  # === SECURITY AND AUTHENTICATION ===
  security.polkit.enable = true;                          # PolicyKit for privilege escalation
  security.pam.services.gdm.enableGnomeKeyring = true;    # GNOME Keyring integration

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
          cursor-theme = "Adwaita";                   # Default cursor theme
          font-name = "Inter 11";                     # UI font (macOS-style)
          document-font-name = "Inter 11";            # Document font (macOS-style)
          monospace-font-name = "RobotoMono Nerd Font 10";  # Terminal/code font (macOS-style)
          gtk-enable-primary-paste = false;           # Disable middle-click paste
          # MODERN INTERFACE ENHANCEMENTS
          color-scheme = "prefer-dark";               # Dark theme default
          show-battery-percentage = true;             # Show battery percentage
          clock-show-weekday = true;                  # Show weekday in clock
          clock-show-seconds = false;                 # Hide seconds for cleaner look
          clock-format = "24h";                       # 24-hour format
          
          # === SAFE PERFORMANCE ADDITIONS ===
          enable-hot-corners = false;                 # Reduce accidental triggers
        };

        # === WINDOW MANAGER OPTIMIZATION ===
        "org/gnome/mutter" = {
          dynamic-workspaces = true;                           # Auto-create/remove workspaces
          workspaces-only-on-primary = false;                 # Workspaces on all monitors
          experimental-features = [ 
            "scale-monitor-framebuffer" 
            "variable-refresh-rate"                            # Gaming monitor support
          ];
          # WINDOW MANAGEMENT ENHANCEMENTS
          center-new-windows = true;                           # Center new windows
          attach-modal-dialogs = false;                        # Separate modal dialogs
          focus-change-on-pointer-rest = false;               # No focus on hover
          auto-maximize = false;                               # No auto-maximize
          check-alive-timeout = lib.gvariant.mkInt32 5000;    # App response timeout (5s)
        };

        # === GNOME SHELL BEHAVIOR ===
        "org/gnome/shell" = {
          enable-hot-corners = false;                                          # Disable hot corners
          app-picker-layout = lib.gvariant.mkEmptyArray lib.gvariant.type.string; # Clean app grid
          # SHELL IMPROVEMENTS
          disabled-extensions = lib.gvariant.mkEmptyArray lib.gvariant.type.string; # Clean extension state
          development-tools = false;                                          # Disable dev tools overlay
          introspect = false;                                                 # Disable debugging introspection
          
          # === SAFE PERFORMANCE ADDITIONS ===
          enabled-extensions = [                                              # Clean extension list
            "appindicator@rgcjonas.gmail.com"
            "dash-to-dock@micxgx.gmail.com" 
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "clipboard-indicator@tudmotu.com"
            "kimpanel@kde.org"                                                # Input method panel for Fcitx5
            "night-theme-switcher@romainvigier.fr"
            "AlphabeticalAppGrid@stuarthayhurst"
            "rounded-corners@fxgn"
            "blur-my-shell@aunetx"
          ];
        };

        # === APP SWITCHER OPTIMIZATION ===
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = false;                                     # Show apps from all workspaces
        };

        # === WINDOW MANAGEMENT PREFERENCES ===
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";  # Window button layout
          focus-mode = "click";                               # Click to focus windows
          resize-with-right-button = true;                    # Right-click resize
        };

        # === KEYBINDINGS OPTIMIZATION ===
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = ["<Super>Tab"];               # App switcher
          switch-windows = ["<Alt>Tab"];                      # Window switcher
          close = ["<Super>q"];                               # Close window (macOS-style)
          toggle-maximized = ["<Super>Up"];                   # Maximize toggle
          move-to-workspace-left = ["<Super><Shift>Left"];    # Move window left workspace
          move-to-workspace-right = ["<Super><Shift>Right"];  # Move window right workspace
          show-desktop = ["<Super>d"];                        # Show desktop
          panel-run-dialog = ["<Super>r"];                    # Run command dialog
        };

        # === CUSTOM MEDIA KEYS ===
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Terminal";
          command = "gnome-terminal";
          binding = "<Super>Return";                          # Super+Enter opens terminal
        };

        # === TOUCHPAD & INPUT OPTIMIZATION ===
        "org/gnome/desktop/peripherals/touchpad" = {
          two-finger-scrolling-enabled = true;
          tap-to-click = true;
          natural-scroll = true;
          # TOUCHPAD ENHANCEMENTS
          disable-while-typing = true;                        # Prevent accidental clicks
          click-method = "fingers";                           # Better click detection
          speed = lib.gvariant.mkDouble 0.3;                 # Comfortable cursor speed
          accel-profile = "adaptive";                         # Adaptive acceleration
          left-handed = false;                                # Right-handed default
          middle-click-emulation = true;                      # 3-finger = middle click
          tap-and-drag = true;                                # Drag after tap
          tap-and-drag-lock = false;                          # No drag lock
        };

        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "adaptive";                         # Mouse acceleration
          left-handed = false;                                # Right-handed default
          middle-click-emulation = false;                     # Real middle click for mice
          natural-scroll = false;                             # Traditional mouse scroll
          speed = lib.gvariant.mkDouble 0.0;                 # Default mouse speed
        };

        # === POWER MANAGEMENT SETTINGS ===
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";                        # Don't sleep on AC power
          sleep-inactive-battery-type = "suspend";                   # Suspend on battery
          sleep-inactive-battery-timeout = lib.gvariant.mkInt32 1800; # 30 minutes battery timeout
        };

        # === PRIVACY & SECURITY SETTINGS ===
        "org/gnome/desktop/privacy" = {
          disable-camera = false;              # Allow camera access
          disable-microphone = false;          # Allow microphone access
          report-technical-problems = false;   # Disable crash reporting
          # PRIVACY ENHANCEMENTS
          remember-recent-files = true;                       # File history enabled
          recent-files-max-age = lib.gvariant.mkInt32 30;    # 30 days max
          remove-old-temp-files = true;                      # Auto cleanup /tmp
          remove-old-trash-files = true;                     # Auto empty trash
          old-files-age = lib.gvariant.mkInt32 30;           # Cleanup after 30 days
          send-software-usage-stats = false;                # No usage statistics
        };

        # === NOTIFICATIONS MANAGEMENT ===
        "org/gnome/desktop/notifications" = {
          show-banners = true;                               # Show notification banners
          show-in-lock-screen = false;                       # Privacy: no lock screen notifications
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
          # NAUTILUS ENHANCEMENTS
          show-create-link = true;                          # Context menu: Create Link
          show-delete-permanently = true;                   # Context menu: Delete permanently
          click-policy = "double";                          # Traditional double-click
          recursive-search = "always";                     # Deep search in subfolders
          show-image-thumbnails = "always";                # Image previews
          thumbnail-limit = lib.gvariant.mkInt32 10;       # Thumbnail size limit (MB)
          executable-text-activation = "ask";              # Ask before running scripts
        };

        "org/gnome/nautilus/list-view" = {
          default-column-order = ["name" "size" "type" "date_modified"];
          default-zoom-level = "standard";                 # Comfortable icon size
        };

        # === TERMINAL CONFIGURATION ===
        "org/gnome/terminal/legacy/profiles:/:default" = {
          font = "RobotoMono Nerd Font 10";  # Terminal font (macOS-style)
          use-system-font = false;     # Use custom font
          audible-bell = false;        # Disable terminal bell
          # TERMINAL ENHANCEMENTS
          use-theme-colors = false;                         # Custom color scheme
          background-color = "rgb(23,20,33)";               # Dark purple background
          foreground-color = "rgb(208,207,204)";            # Light foreground
          scrollback-lines = lib.gvariant.mkInt32 10000;   # More history
          scroll-on-output = false;                         # Don't auto-scroll on output
          scroll-on-keystroke = true;                       # Scroll on typing
          allow-bold = true;                                # Bold text support
          cursor-shape = "block";                           # Block cursor
          cursor-blink-mode = "on";                         # Blinking cursor
          background-transparency-percent = lib.gvariant.mkInt32 15; # Semi-transparent terminal
          use-transparent-background = true;                # Enable transparency
        };

        # === MODERN UI TRANSPARENCY EFFECTS ===
        "org/gnome/shell/extensions/blur-my-shell" = {
          # Panel blur effects
          panel-blur = true;                                # Enable panel blur
          panel-brightness = lib.gvariant.mkDouble 0.8;    # Panel brightness (80%)
          panel-sigma = lib.gvariant.mkInt32 15;           # Panel blur strength
          
          # Overview blur effects  
          overview-blur = true;                             # Enable overview blur
          overview-brightness = lib.gvariant.mkDouble 0.7; # Overview brightness (70%)
          overview-sigma = lib.gvariant.mkInt32 25;        # Overview blur strength
          
          # Lock screen blur
          lockscreen-blur = true;                           # Enable lock screen blur
          lockscreen-brightness = lib.gvariant.mkDouble 0.5; # Lock screen brightness (50%)
          lockscreen-sigma = lib.gvariant.mkInt32 20;      # Lock screen blur strength
          
          # App folder blur
          appfolder-blur = true;                            # Enable app folder blur
          appfolder-brightness = lib.gvariant.mkDouble 0.8; # App folder brightness (80%)
          appfolder-sigma = lib.gvariant.mkInt32 20;       # App folder blur strength
          
          # Dash blur effects
          dash-blur = true;                                 # Enable dash blur
          dash-brightness = lib.gvariant.mkDouble 0.85;    # Dash brightness (85%)
          dash-sigma = lib.gvariant.mkInt32 12;            # Dash blur strength
          
          # Window list blur
          window-list-blur = true;                          # Enable window list blur
          window-list-brightness = lib.gvariant.mkDouble 0.8; # Window list brightness (80%)
          window-list-sigma = lib.gvariant.mkInt32 15;     # Window list blur strength
          
          # Performance optimizations
          hacks-level = lib.gvariant.mkInt32 1;            # Conservative performance mode
        };

        # === DASH TO DOCK TRANSPARENCY ===
        "org/gnome/shell/extensions/dash-to-dock" = {
          # Dock appearance
          transparency-mode = "DYNAMIC";                    # Dynamic transparency based on windows
          background-opacity = lib.gvariant.mkDouble 0.7;  # Semi-transparent dock (70%)
          customize-alphas = true;                          # Custom transparency settings
          min-alpha = lib.gvariant.mkDouble 0.4;          # Minimum transparency (40%)
          max-alpha = lib.gvariant.mkDouble 0.9;          # Maximum transparency (90%)
          
          # Blur effects
          force-straight-corner = false;                    # Rounded corners for modern look
          apply-custom-theme = true;                        # Enable custom theming
          custom-background-color = false;                  # Use theme colors
          
          # Position and behavior
          dock-position = "BOTTOM";                         # Bottom dock like macOS
          extend-height = false;                            # Don't extend full height
          dock-fixed = false;                               # Auto-hide dock
          intellihide-mode = "FOCUS_APPLICATION_WINDOWS";   # Hide when windows overlap
          
          # Animation settings
          animation-time = lib.gvariant.mkDouble 0.3;      # Smooth animations (300ms)
          hide-delay = lib.gvariant.mkDouble 0.2;          # Quick hide delay (200ms)
          show-delay = lib.gvariant.mkDouble 0.1;          # Quick show delay (100ms)
          
          # Icon settings
          click-action = "PREVIEWS";                        # Show window previews on click
          scroll-action = "CYCLE_WINDOWS";                  # Cycle windows on scroll
          show-running = true;                              # Show running app indicators
          show-apps-at-top = false;                         # Apps at natural order
        };

        # === ROUNDED CORNERS ENHANCEMENT ===
        "org/gnome/shell/extensions/rounded-window-corners" = {
          # Global settings
          global-rounded-corner-settings = true;           # Apply to all windows
          border-radius = lib.gvariant.mkInt32 12;         # Modern corner radius (12px)
          
          # Window type specific settings
          maximized-window-exclude = false;                # Round maximized windows too
          fullscreen-window-exclude = true;                # Exclude fullscreen windows
          
          # Performance
          skip-libadwaita-app = false;                      # Apply to modern GNOME apps
          skip-libhandy-app = false;                        # Apply to older GNOME apps
        };
      };
    }];
  };

  # === HARDWARE ACCELERATION FOR GRAPHICS PERFORMANCE ===
  hardware.graphics = {
    enable = true;       # Enable graphics acceleration
    enable32Bit = true;  # 32-bit graphics support for gaming/legacy apps
  };

  # === ENHANCED FLATPAK INTEGRATION ===
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  
  # === X11 FALLBACK DESKTOP ENTRIES ===
  # For apps that have issues with Wayland
  environment.etc = {
    "xdg/applications/cursor-x11.desktop".text = ''
      [Desktop Entry]
      Name=Cursor (X11)
      Comment=AI-powered code editor with X11 support (stable)
      GenericName=Code Editor
      Exec=env -u NIXOS_OZONE_WL ELECTRON_OZONE_PLATFORM_HINT=x11 cursor %F
      Icon=cursor
      Type=Application
      StartupNotify=true
      Categories=Development;TextEditor;Utility;
      MimeType=text/plain;inode/directory;
      Keywords=cursor;x11;editor;code;stable;
    '';
    
    "xdg/applications/discord-x11.desktop".text = ''
      [Desktop Entry]
      Name=Discord (X11)
      StartupWMClass=discord
      Comment=All-in-one voice and text chat with X11 support (stable)
      GenericName=Internet Messenger
      Exec=env -u NIXOS_OZONE_WL ELECTRON_OZONE_PLATFORM_HINT=x11 discord
      Icon=discord
      Type=Application
      Categories=Network;InstantMessaging;
      Keywords=discord;x11;chat;gaming;stable;
    '';
  };
}

