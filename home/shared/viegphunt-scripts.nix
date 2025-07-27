{ config, pkgs, ... }:

{
  # === VIEGPHUNT SCRIPTS SETUP ===
  # Create ViegPhunt scripts inline
  
  home.file.".config/viegphunt/wallpaper_select.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Select wallpaper script
      wallpaper_dir="$HOME/Pictures/Wallpapers"
      if [ -d "$wallpaper_dir" ]; then
          selected=$(ls "$wallpaper_dir" | rofi -dmenu -p "Select Wallpaper")
          if [ -n "$selected" ]; then
              swww img "$wallpaper_dir/$selected"
          fi
      else
          echo "Wallpaper directory not found: $wallpaper_dir"
      fi
    '';
    executable = true;
  };
  
  home.file.".config/viegphunt/wallpaper_random.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Random wallpaper script
      wallpaper_dir="$HOME/Pictures/Wallpapers"
      if [ -d "$wallpaper_dir" ]; then
          random_wallpaper=$(ls "$wallpaper_dir" | shuf -n1)
          swww img "$wallpaper_dir/$random_wallpaper"
      else
          echo "Wallpaper directory not found: $wallpaper_dir"
      fi
    '';
    executable = true;
  };
  
  home.file.".config/viegphunt/gtkthemes.sh" = {
    text = ''
      #!/usr/bin/env bash
      # GTK themes script
      SCHEME='prefer-dark'
      THEME='Catppuccin-Mocha-Compact-Blue-Dark'
      ICONS='Papirus-Dark'
      CURSOR='WhiteSur-cursors'
      FONT='JetBrainsMono Nerd Font 11'
      
      SCHEMA='gsettings set org.gnome.desktop.interface'
      
      apply_themes() {
          $SCHEMA color-scheme "$SCHEME"
          $SCHEMA gtk-theme "$THEME"
          $SCHEMA icon-theme "$ICONS"
          $SCHEMA cursor-theme "$CURSOR"
          $SCHEMA font-name "$FONT"
      }
      
      apply_themes
    '';
    executable = true;
  };
  
  home.file.".config/viegphunt/setcursor.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Set cursor script
      gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
      gsettings set org.gnome.desktop.interface cursor-size 24
    '';
    executable = true;
  };
  
  home.file.".config/viegphunt/wallpaper_effects.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Wallpaper effects script
      swww-daemon &
      sleep 0.5
      swww init
    '';
    executable = true;
  };
} 