{ config, pkgs, lib, ... }:

{
  # GNOME Home Manager Configuration for Modern Experience
  dconf.settings = {
    # Interface and appearance settings
    "org/gnome/desktop/interface" = {
      # Modern UI settings
      enable-animations = true;
      show-battery-percentage = true;
      clock-show-weekday = true;
      clock-show-seconds = false;
      clock-format = "24h";
      
      # Theme settings
      gtk-theme = "Adwaita";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Bibata-Modern-Ice";
      
      # Font settings
      font-name = "Inter 11";
      document-font-name = "Inter 11"; 
      monospace-font-name = "JetBrains Mono 10";
      
      # Behavior
      gtk-enable-primary-paste = false;
      locate-pointer = true;
    };

    # Window Manager settings for smooth performance
    "org/gnome/mutter" = {
      # Enable modern features
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
      center-new-windows = true;
      
      # Performance optimizations
      experimental-features = [ "scale-monitor-framebuffer" "rt-scheduler" ];
      
      # Multi-monitor behavior
      edge-tiling = true;
    };

    # Shell customizations
    "org/gnome/shell" = {
      # Disable hot corners for better workflow
      enable-hot-corners = false;
      
      # Favorite apps in dock
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.Terminal.desktop"
        "code.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Settings.desktop"
      ];
      
      # Extensions to auto-enable
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "Vitals@CoreCoding.com"
        "clipboard-indicator@tudmotu.com"
        "blur-my-shell@aunetx"
        "just-perfection-desktop@just-perfection"
        "space-bar@luchrioh"
        "caffeine@patapon.info"
        "tiling-assistant@leleat-on-github"
      ];
    };

    # Window management preferences
    "org/gnome/desktop/wm/preferences" = {
      # Button layout (Windows-like - controls on the right)
      button-layout = "appmenu:minimize,maximize,close";
      
      # Focus behavior
      focus-mode = "click";
      resize-with-right-button = true;
      
      # Window behavior
      raise-on-click = true;
      auto-raise = false;
      
      # Workspaces
      num-workspaces = 4;
      workspace-names = [ "Main" "Development" "Communication" "Media" ];
    };

    # Keybindings for productivity
    "org/gnome/desktop/wm/keybindings" = {
      # Window management
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>m" ];
      minimize = [ "<Super>h" ];
      
      # Workspace switching
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      
      # Move windows to workspaces
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      
      # Window tiling
      move-to-side-e = [ "<Super>Right" ];
      move-to-side-w = [ "<Super>Left" ];
      move-to-center = [ "<Super>c" ];
    };

    # Custom keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Application shortcuts
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      
      # System shortcuts
      screensaver = [ "<Super>l" ];
      home = [ "<Super>e" ];
      www = [ "<Super>b" ];
    };

    # Custom application shortcuts
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "gnome-terminal";
      binding = "<Super>Return";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "File Manager";
      command = "nautilus";
      binding = "<Super>e";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "System Monitor";
      command = "gnome-system-monitor";
      binding = "<Ctrl><Alt>Delete";
    };

    # Power management for performance
    "org/gnome/settings-daemon/plugins/power" = {
      # AC power settings
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-ac-timeout = 0;
      
      # Battery settings
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900; # 15 minutes
      
      # Brightness
      ambient-enabled = false;
      idle-brightness = 30;
      idle-dim = true;
    };

    # Privacy settings
    "org/gnome/desktop/privacy" = {
      # Disable usage stats
      report-technical-problems = false;
      send-software-usage-stats = false;
      
      # File history
      remember-recent-files = true;
      recent-files-max-age = 30;
      
      # Location
      disable-camera = false;
      disable-microphone = false;
    };

    # Search settings
    "org/gnome/desktop/search-providers" = {
      disable-external = false;
      disabled = [ "org.gnome.Software.desktop" ];
    };

    # Nautilus file manager
    "org/gnome/nautilus/preferences" = {
      # View settings
      default-folder-viewer = "list-view";
      default-sort-order = "name";
      
      # Behavior
      click-policy = "double";
      executable-text-activation = "ask";
      
      # Search
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      
      # Sidebar
      show-create-link = true;
      show-delete-permanently = true;
      show-hidden-files = false;
    };

    # Terminal settings
    "org/gnome/terminal/legacy/profiles:/:default" = {
      # Appearance
      font = "JetBrains Mono 11";
      use-system-font = false;
      
      # Behavior
      audible-bell = false;
      scroll-on-output = false;
      scroll-on-keystroke = true;
      scrollback-unlimited = true;
      
      # Colors (use system theme)
      use-theme-colors = true;
      use-theme-transparency = false;
    };

    # Text editor (if using gedit)
    "org/gnome/gedit/preferences/editor" = {
      scheme = "Adwaita-dark";
      tabs-size = 2;
      insert-spaces = true;
      auto-indent = true;
      display-line-numbers = true;
      highlight-current-line = true;
      bracket-matching = true;
      wrap-mode = "word";
    };

    # Calendar settings
    "org/gnome/calendar" = {
      active-view = "month";
      weather-settings = lib.hm.gvariant.mkTuple [
        true  # automatic-location
        "[]"  # locations (empty array as string)
      ];
    };

    # Weather settings
    "org/gnome/Weather" = {
      automatic-location = true;
    };

    # Extensions settings
    
    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      # Position and size
      dock-position = "BOTTOM";
      preferred-monitor = -2;
      dock-fixed = false;
      
      # Behavior
      autohide = true;
      autohide-in-fullscreen = true;
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      
      # Appearance
      transparency-mode = "DYNAMIC";
      running-indicator-style = "DOTS";
      apply-custom-theme = false;
      
      # Icon settings
      dash-max-icon-size = 48;
      show-trash = false;
      show-mounts = true;
      
      # Click behavior
      click-action = "minimize-or-overview";
      middle-click-action = "launch";
      shift-click-action = "minimize";
      shift-middle-click-action = "launch";
    };

    # Vitals extension
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [ "_processor_usage_" "_memory_usage_" "_temperature_max_" ];
      position-in-panel = 2; # center
      use-higher-precision = false;
      alphabetize = true;
      hide-icons = false;
    };

    # Blur My Shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      # Panel blur
      panel-blur = true;
      panel-opacity = 0.6;
      
      # Overview blur
      overview-blur = true;
      overview-style-components = 2;
      
      # Applications blur
      applications-blur = false;
    };

    # Just Perfection
    "org/gnome/shell/extensions/just-perfection" = {
      # Panel
      panel = true;
      panel-in-overview = true;
      
      # Activities button
      activities-button = true;
      
      # App menu
      app-menu = true;
      app-menu-icon = true;
      
      # Clock
      clock-menu = true;
      clock-menu-position = 1;
      clock-menu-position-offset = 0;
      
      # System menu
      aggregate-menu = true;
      
      # Other elements
      dash = true;
      osd = true;
      workspace-popup = true;
      workspace-switcher-popup = true;
      workspace = true;
      workspace-wrap-around = false;
      
      # Window demands attention focus
      window-demands-attention-focus = false;
      
      # Startup status
      startup-status = 0;
      
      # Weather
      weather = true;
    };

    # Tiling Assistant
    "org/gnome/shell/extensions/tiling-assistant" = {
      # Enable tiling
      enable-tiling-popup = true;
      enable-advanced-experimental-features = true;
      
      # Layout settings
      dynamic-keybinding-behavior = 2;
      quarter-tiling-threshold = 25;
      
      # Window gaps
      window-gap = 8;
      single-screen-gap = 8;
      
      # Restore window size
      restore-window-size-on-grab-end = true;
      
      # Active window hint
      active-window-hint = 1;
      active-window-hint-color = "rgb(211,70,21)";
    };
  };

  # GTK configuration
  gtk = {
    enable = true;
    
    # Theme settings
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    
    font = {
      name = "Inter";
      size = 11;
    };

    # GTK3 settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
      gtk-button-images = 1;
      gtk-decoration-layout = ":minimize,maximize,close";
      gtk-enable-animations = 1;
      gtk-menu-images = 1;
      gtk-primary-button-warps-slider = 0;
      gtk-toolbar-style = 3;
      gtk-toolbar-icon-size = 1;
    };

    # GTK4 settings
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
      gtk-decoration-layout = ":minimize,maximize,close";
      gtk-enable-animations = 1;
    };
  };

  # Install user-specific packages
  home.packages = with pkgs; [
    # GNOME utilities
    gnome-tweaks
    dconf-editor
    
    # Additional fonts
    inter
    jetbrains-mono
    cascadia-code
    
    # Theme packages
    papirus-icon-theme
    bibata-cursors
    
    # Development tools
    git
    htop
    
    # Media tools
    mpv
    gimp
    
    # Productivity
    libreoffice
    
    # System tools
    gparted
    neofetch
    tree
  ];

  # Home Manager state version
  home.stateVersion = "25.05";
} 