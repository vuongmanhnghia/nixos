{ config, pkgs, lib, ... }:
{
  # GNOME Desktop Environment - Modern Configuration for GNOME 25.05
  services.xserver = {
    enable = true;                      # Bật X11 server
    displayManager.gdm.enable = true;   # Sử dụng GDM làm display manager
    desktopManager.gnome.enable = true; # Bật GNOME desktop
  };

  # GNOME-specific packages with modern extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
    gnome-shell-extensions
    
    # Essential modern extensions for productivity
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock         # Dock ở dưới màn hình như macOS/Ubuntu
    gnomeExtensions.user-themes          # Cho phép dùng custom themes
    gnomeExtensions.vitals               # Hiển thị system stats trên top bar
    gnomeExtensions.clipboard-indicator  # Quản lý clipboard history
    gnomeExtensions.pop-shell            # Tiling window manager như i3
    
    # Modern UI/UX enhancements
    gnomeExtensions.blur-my-shell        # Blur effects cho shell
    gnomeExtensions.caffeine             # Prevent system sleep
    gnomeExtensions.gsconnect            # Android phone integration
    gnomeExtensions.just-perfection      # Customize GNOME shell elements
    gnomeExtensions.space-bar            # Workspace indicator
    gnomeExtensions.quick-settings-tweaker # Customize quick settings
    gnomeExtensions.tiling-assistant     # Advanced window tiling
    gnomeExtensions.window-list          # Window list in panel
    gnomeExtensions.workspace-indicator  # Workspace switching
    
    # Additional GNOME apps
    nautilus                       # File manager
    gnome-calculator               # Calculator
    gnome-calendar                 # Calendar
    gnome-weather                  # Weather app
    gnome-clocks                   # Clock/timer app
    gnome-system-monitor           # System monitor
    gnome-disk-utility             # Disk management
    gnome-screenshot               # Screenshot tool
    file-roller                    # Archive manager
    
    # Media and graphics
    eog                                  # Image viewer
    evince                              # PDF viewer
    totem                               # Video player
    
    # Modern fonts for better GNOME experience
    inter                               # Modern UI font
    jetbrains-mono                      # Monospace font
    noto-fonts                          # Google fonts
    noto-fonts-emoji                    # Emoji support
    liberation_ttf                      # Microsoft fonts alternative
    cascadia-code                       # Microsoft's modern coding font
    source-code-pro                     # Adobe's coding font
    
    # Modern themes and icons
    papirus-icon-theme                  # Popular icon theme
    tela-icon-theme                     # Modern flat icons
    bibata-cursors                      # Modern cursor theme
    adwaita-qt                          # Qt theme matching GTK
    adwaita-qt6                         # Qt6 support
    
    # Performance and system tools
    htop                                # Better system monitor
    neofetch                           # System info display
    gparted                            # Advanced disk management
  ];

  # Exclude some default GNOME applications we don't need
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    cheese
    gnome-music
    epiphany
    geary
    gnome-characters
    tali
    iagno
    hitori
    atomix
    gnome-contacts
    gnome-initial-setup
    gedit
    gnome-maps                    # Maps app
    gnome-software                # Software center (sử dụng nix thay thế)
    simple-scan                         # Scanner app
    yelp                               # Help viewer
  ];

  # Enable GNOME services with optimizations
  services = {
    gnome = {
      gnome-keyring.enable = true;
      evolution-data-server.enable = true;
      gnome-settings-daemon.enable = true;
      gnome-online-accounts.enable = true;  # Online accounts integration
      localsearch.enable = true;            # File indexing (renamed from tracker-miners)
      tinysparql.enable = true;             # Search functionality (renamed from tracker)
    };
    
    # Auto login for better user experience
    displayManager.autoLogin = {
      enable = true;
      user = "nagih";
    };
    
    # Additional services for better GNOME experience
    udev.packages = with pkgs; [ gnome-settings-daemon ];
    dbus.packages = with pkgs; [ dconf ];
    
    # Enable location services for weather, time zone
    geoclue2.enable = true;
    
    # Enable printing support
    printing = {
      enable = true;
      drivers = with pkgs; [ hplip epson-escpr ];
    };
  };

  # Modern GDM configuration with Wayland
  services.xserver.displayManager.gdm = {
    wayland = true;
    autoSuspend = false;
    # Enable experimental features for better performance
    settings = {
      daemon = {
        WaylandEnable = true;
        # Disable initial setup
        InitialSetupEnable = false;
      };
    };
  };

  # PipeWire for superior audio (better than PulseAudio for modern GNOME)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # Optimize for low latency
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
  };

  # Network configuration optimized for GNOME
  networking.networkmanager = {
    enable = true;
    # Enable better Wi-Fi performance
    wifi = {
      powersave = false;
      backend = "iwd"; # Modern WiFi backend
    };
  };
  
  # Modern Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; # Enable experimental features
      };
    };
  };
  services.blueman.enable = true;

  # XDG portals for proper modern app integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "gnome";
  };

  # Modern power management (choose one: either power-profiles-daemon OR tlp)
  services.power-profiles-daemon.enable = true;
  # services.upower.enable = true;  # Keep upower for battery info
  
  # TLP disabled to avoid conflict with power-profiles-daemon
  # For laptops, you can choose TLP instead by commenting power-profiles-daemon above
  # and uncommenting the TLP configuration below:
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #   };
  # };

  # Enable firmware updates through GNOME Software
  services.fwupd.enable = true;

  # Enable flatpak for additional app installation
  services.flatpak.enable = true;

  # Modern environment variables for optimal performance
  environment.sessionVariables = {
    # Enable Wayland for compatible apps
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1"; # Electron apps on Wayland
    
    # Optimize graphics
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    
    # Enable hardware acceleration (Intel by default, NVIDIA module will override)
    LIBVA_DRIVER_NAME = lib.mkDefault "iHD"; # Intel (will be overridden by NVIDIA if present)
    
    # GNOME-specific optimizations
    GNOME_SHELL_SLOWDOWN_FACTOR = "0.5"; # Faster animations
    GSK_RENDERER = "ngl"; # New GL renderer for better performance
  };

  # Modern font configuration
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      jetbrains-mono
      cascadia-code
      source-code-pro
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      source-han-sans
      source-han-serif
      roboto
      roboto-mono
    ];
    
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Inter" "Roboto" "Noto Sans" "Source Han Sans" ];
        monospace = [ "JetBrains Mono" "Cascadia Code" "Source Code Pro" "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Security and authentication
  security.polkit.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  
  # CUPS for printing with modern discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Thumbnail generation for file manager
  services.tumbler.enable = true;

  # GVfs for modern file system support
  services.gvfs.enable = true;

  # User groups for full GNOME functionality
  users.users.nagih.extraGroups = [ 
    "networkmanager" 
    "wheel" 
    "audio" 
    "video" 
    "input" 
    "power"
    "lp"        # printing
    "scanner"   # scanning
    "dialout"   # serial devices
    "plugdev"   # removable devices
  ];

  # dconf settings for optimized GNOME experience
  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings = {
        # Enable modern animations and smooth experience
        "org/gnome/desktop/interface" = {
          enable-animations = true;
          gtk-theme = "Adwaita";
          icon-theme = "Papirus";
          cursor-theme = "Bibata-Modern-Classic";
          font-name = "Inter 11";
          document-font-name = "Inter 11";
          monospace-font-name = "JetBrains Mono 10";
          # Smooth animations
          gtk-enable-primary-paste = false;
        };

        # Optimize window manager performance
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          workspaces-only-on-primary = false;
          # Enable experimental features for better performance
          experimental-features = [ "scale-monitor-framebuffer" ];
        };

        # Shell behavior optimizations
        "org/gnome/shell" = {
          # Faster overview animations
          enable-hot-corners = false;
          # App grid settings
          app-picker-layout = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        };

        # Window management
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
          focus-mode = "click";
          resize-with-right-button = true;
        };

        # Power settings for better performance
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-battery-type = "suspend";
          sleep-inactive-battery-timeout = lib.gvariant.mkInt32 1800;
        };

        # Privacy settings
        "org/gnome/desktop/privacy" = {
          disable-camera = false;
          disable-microphone = false;
          report-technical-problems = false;
        };

        # Search settings
        "org/gnome/desktop/search-providers" = {
          disable-external = false;
        };

        # File manager settings
        "org/gnome/nautilus/preferences" = {
          default-folder-viewer = "list-view";
          search-filter-time-type = "last_modified";
          show-hidden-files = false;
        };

        # Terminal settings
        "org/gnome/terminal/legacy/profiles:/:default" = {
          font = "JetBrains Mono 10";
          use-system-font = false;
          audible-bell = false;
        };
      };
    }];
  };

  # Hardware acceleration for better graphics performance
  hardware.graphics = {
    enable = true;
    # driSupport = true;  # Removed - no longer needed in modern NixOS
    # driSupport32Bit = true;  # Removed - no longer needed in modern NixOS
    extraPackages = with pkgs; [
      intel-media-driver # Intel VAAPI
      vaapiIntel         # Intel VA-API
      vaapiVdpau         # VDPAU backend for VA-API
      libvdpau-va-gl     # VDPAU driver
    ];
  };
}
