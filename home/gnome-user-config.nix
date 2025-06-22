{ config, pkgs, lib, ... }:

{
  # GNOME Home Manager Configuration - Optimized Version
  dconf.settings = {
    # Essential interface settings
    "org/gnome/desktop/interface" = {
      # Core UI settings
      enable-animations = true;
      show-battery-percentage = true;
      clock-show-weekday = true;
      clock-format = "24h";
      
      # Theme settings
      gtk-theme = "Adwaita";
      icon-theme = "Papirus-Dark";
      # cursor-theme = "Bibata-Modern-Ice";  # Removed to use default cursor
      
      # Font settings
      font-name = "Inter 11";
      document-font-name = "Inter 11"; 
      monospace-font-name = "JetBrains Mono 10";
      
      # Essential behavior
      gtk-enable-primary-paste = false;
      locate-pointer = true;
    };

    # Window Manager - Performance focused
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      center-new-windows = true;
      experimental-features = [ "scale-monitor-framebuffer" "rt-scheduler" ];
      edge-tiling = true;
    };

    # Shell customizations - Essential only
    "org/gnome/shell" = {
      enable-hot-corners = false;
      
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.Terminal.desktop"
        "code.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Settings.desktop"
      ];
      
      # Essential extensions only
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "Vitals@CoreCoding.com"
        "blur-my-shell@aunetx"
        "tiling-assistant@leleat-on-github"
      ];
    };

    # Window management - Core settings
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
      resize-with-right-button = true;
      num-workspaces = 4;
    };

    # Essential keybindings
    "org/gnome/desktop/wm/keybindings" = {
      # Core window management
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>m" ];
      
      # Workspace switching
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      
      # Window tiling
      move-to-side-e = [ "<Super>Right" ];
      move-to-side-w = [ "<Super>Left" ];
    };

    # Custom shortcuts - Essential only
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      screensaver = [ "<Super>l" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "gnome-terminal";
      binding = "<Super>Return";
    };

    # Power management - Optimized
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      idle-dim = true;
    };

    # Privacy - Essential settings
    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
      send-software-usage-stats = false;
      remember-recent-files = true;
      recent-files-max-age = 30;
    };

    # Nautilus - Simplified
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      click-policy = "double";
    };

    # Terminal - Essential settings
    "org/gnome/terminal/legacy/profiles:/:default" = {
      font = "JetBrains Mono 11";
      use-system-font = false;
      audible-bell = false;
      scrollback-unlimited = true;
      use-theme-colors = true;
    };

    # Extension configurations
    
    # Dash to Dock - Streamlined
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      autohide = true;
      intellihide = true;
      transparency-mode = "DYNAMIC";
      dash-max-icon-size = 48;
      show-trash = false;
      click-action = "minimize-or-overview";
    };

    # Vitals - Simple monitoring
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [ "_processor_usage_" "_memory_usage_" "_temperature_max_" ];
      position-in-panel = 2;
      hide-icons = false;
    };

    # Blur My Shell - Performance focused
    "org/gnome/shell/extensions/blur-my-shell" = {
      panel-blur = true;
      panel-opacity = 0.8;
      overview-blur = true;
      applications-blur = false;
    };

    # Tiling Assistant - Essential features
    "org/gnome/shell/extensions/tiling-assistant" = {
      enable-tiling-popup = true;
      window-gap = 8;
      restore-window-size-on-grab-end = true;
      active-window-hint = 1;
    };
  };

  # GTK configuration - Simplified
  gtk = {
    enable = true;
    
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    
    # cursorTheme = {                      # Removed to use default cursor
    #   name = "Bibata-Modern-Ice";
    #   package = pkgs.bibata-cursors;
    #   size = 24;
    # };
    
    font = {
      name = "Inter";
      size = 11;
    };

    # Minimal GTK settings
    gtk3.extraConfig = {
      gtk-decoration-layout = ":minimize,maximize,close";
      gtk-enable-animations = 1;
    };

    gtk4.extraConfig = {
      gtk-decoration-layout = ":minimize,maximize,close";
      gtk-enable-animations = 1;
    };
  };

  # Essential packages only
  home.packages = with pkgs; [
    # GNOME core utilities
    gnome-tweaks
    dconf-editor
    
    # Essential fonts
    inter
    jetbrains-mono
    
    # Theme packages
    papirus-icon-theme
    # bibata-cursors                       # Removed to use default cursor
    
    # Core development tools
    git
    htop
    
    # Essential productivity
    libreoffice
    
    # Basic system tools
    tree
  ];

  home.stateVersion = "25.05";
} 