{ config, pkgs, ... }:

{
  # Desktop applications and tools
  home.packages = with pkgs; [
    # File management
    file-roller
    
    # System monitoring
    gnome-system-monitor
    
    # Utilities
    gnome-calculator
    gnome-calendar
    gnome-weather
    
    # Screenshots
    gnome-screenshot
    flameshot
  ];
  
  # Desktop environment settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      font-name = "Inter 11";
      monospace-font-name = "JetBrains Mono 10";
    };
    
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
  };
  
  # GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
  };
} 