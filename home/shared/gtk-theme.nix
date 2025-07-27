{ config, pkgs, ... }:

{
  # === GTK THEME CONFIGURATION ===
  gtk = {
    enable = true;
    
    # === CATPPUCCIN GTK THEME ===
    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "compact";
        variant = "mocha";
      };
    };
    
    # === PAPIRUS ICON THEME ===
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    
    # === WHITESUR CURSOR THEME ===
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
      size = 24;
    };
    
    # === FONT CONFIGURATION ===
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    
    # === GTK SETTINGS ===
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-theme-name = "Catppuccin-Mocha-Compact-Blue-Dark";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-cursor-theme-name = "WhiteSur-cursors";
      gtk-font-name = "JetBrainsMono Nerd Font 11";
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-theme-name = "Catppuccin-Mocha-Compact-Blue-Dark";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-cursor-theme-name = "WhiteSur-cursors";
      gtk-font-name = "JetBrainsMono Nerd Font 11";
    };
  };
  
  # === QT THEME CONFIGURATION ===
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
} 