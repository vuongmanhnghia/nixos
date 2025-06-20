{ config, pkgs, ... }:
{
  # GNOME Desktop Environment
  services.xserver = {
    enable = true;                      # Bật X11 server
    displayManager.gdm.enable = true;   # Sử dụng GDM làm display manager
    desktopManager.gnome.enable = true; # Bật GNOME desktop
  };

  # GNOME-specific packages
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    # gnome-extensions-app
    dconf-editor
    gnome-shell-extensions
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock         # Dock ở dưới màn hình như macOS/Ubuntu
    gnomeExtensions.user-themes          # Cho phép dùng custom themes
    gnomeExtensions.vitals		 # Hiển thị system stats trên top bar
    gnomeExtensions.clipboard-indicator  # Quản lý clipboard history
    gnomeExtensions.pop-shell 		 # Tiling window manager như i3
    
    # Additional useful extensions
    gnomeExtensions.blur-my-shell        # Blur effects cho shell
    gnomeExtensions.caffeine             # Prevent system sleep
    gnomeExtensions.gsconnect            # Android phone integration
    gnomeExtensions.just-perfection      # Customize GNOME shell elements
    gnomeExtensions.space-bar            # Workspace indicator
    gnomeExtensions.quick-settings-tweaker # Customize quick settings
    
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
    
    # Fonts for better GNOME experience
    inter                               # Modern UI font
    jetbrains-mono                      # Monospace font
    noto-fonts                          # Google fonts
    noto-fonts-emoji                    # Emoji support
    liberation_ttf                      # Microsoft fonts alternative
    
    # Themes and icons
    papirus-icon-theme                  # Popular icon theme
    bibata-cursors                      # Modern cursor theme
    adwaita-qt                          # Qt theme matching GTK
  ];

  # Exclude some default GNOME applications
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

  # Enable GNOME services
  services = {
    gnome = {
      gnome-keyring.enable = true;
      evolution-data-server.enable = true;
      gnome-settings-daemon.enable = true;
      gnome-online-accounts.enable = true;  # Online accounts integration
      localsearch.enable = true;        # File indexing (was tracker-miners)
      tinysparql.enable = true;         # Search functionality (was tracker)
    };
    
    # Auto login - DISABLED temporarily to fix boot issues
    displayManager.autoLogin = {
      enable = false;  # Changed from true to false
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

  # GDM configuration
  services.xserver.displayManager.gdm = {
    wayland = true;
    autoSuspend = false;
  };

  # Additional system configuration for GNOME
  # Enable sound with pipewire (better than pulseaudio for GNOME)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable network manager for GNOME network settings
  networking.networkmanager.enable = true;
  
  # Enable bluetooth for GNOME bluetooth settings
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;

  # XDG portals for proper integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # Power management
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Enable fwupd for firmware updates through GNOME Software
  services.fwupd.enable = true;

  # Enable flatpak support (alternative app installation)
  services.flatpak.enable = true;

  # Environment variables for better GNOME experience
  environment.sessionVariables = {
    # Enable Wayland for Firefox and other apps
    MOZ_ENABLE_WAYLAND = "1";
    # Better scaling for some applications
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    # Enable hardware acceleration
    # LIBVA_DRIVER_NAME = "iHD"; # for Intel
    # LIBVA_DRIVER_NAME = "radeonsi"; # for AMD
  };

  # Fonts configuration
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      source-han-sans
      source-han-serif
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Inter" "Noto Sans" "Source Han Sans" ];
        monospace = [ "JetBrains Mono" "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Security and polkit for GNOME
  security.polkit.enable = true;
  
  # Enable CUPS for printing through GNOME
  services.avahi = {
    enable = true;
    nssmdns4 = true;  # Updated from nssmdns
    openFirewall = true;
  };

  # Thumbnail generation
  services.tumbler.enable = true;

  # Enable gvfs for trash, network browsing, etc.
  services.gvfs.enable = true;

  # User groups for GNOME functionality
  users.users.nagih.extraGroups = [ 
    "networkmanager" 
    "wheel" 
    "audio" 
    "video" 
    "input" 
    "power"
    "lp"  # printing
    "scanner"  # scanning
  ];
}
