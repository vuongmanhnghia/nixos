{ config, pkgs, lib, ... }:

{
  # GNOME User Configuration - Simplified
  dconf.settings = {
    # Interface basics
    "org/gnome/desktop/interface" = {
      enable-animations = true;
      show-battery-percentage = true;
      clock-format = "24h";
      gtk-theme = "Adwaita";
      icon-theme = "Papirus-Dark";
      font-name = "Inter 11";
      monospace-font-name = "JetBrains Mono 10";
    };

    # Window manager essentials
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      center-new-windows = true;
      edge-tiling = true;
    };

    # Shell favorites
    "org/gnome/shell" = {
      enable-hot-corners = false;
      favorite-apps = [ ];
    };

    # Essential keybindings
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>m" ];
      move-to-side-e = [ "<Super>Right" ];
      move-to-side-w = [ "<Super>Left" ];
    };

    # Terminal shortcut
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "gnome-terminal";
      binding = "<Super>Return";
    };

    # Power - laptop friendly
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
    };

    # Privacy basics
    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
      send-software-usage-stats = false;
    };

    # Terminal settings
    "org/gnome/terminal/legacy/profiles:/:default" = {
      font = "JetBrains Mono 11";
      use-system-font = false;
      audible-bell = false;
      scrollback-unlimited = true;
    };
  };

  # GTK theme
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
    
    font = {
      name = "Inter";
      size = 11;
    };
  };
} 