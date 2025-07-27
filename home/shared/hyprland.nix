{ config, pkgs, lib, ... }:

{
  # === ENHANCED HYPRLAND HOME MANAGER CONFIG ===
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # === MONITOR ===
      monitor = [
        ",preferred,auto,1"
      ];

      # === INPUT ===
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        
        touchpad = {
          natural_scroll = false;
        };
      };

      # === ENHANCED APPEARANCE (ViegPhunt style) ===
      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(cdd6f4aa)";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };
      
      decoration = {
        rounding = 2;
        rounding_power = 2;
        
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };
      
      animations = {
        enabled = true;
        
        bezier = [
          "ease, 0.25, 0.1, 0.25, 1.0"
          "overshot, 0.13, 0.99, 0.29, 1.05"
        ];
        
        animation = [
          "windows, 1, 5, overshot, gnomed"
          "windowsOut, 1, 5, ease, slide bottom"
          "windowsMove, 1, 5, overshot, slide"
          "layers, 1, 5, ease, gnomed"
          "fade, 1, 3, ease"
          "border, 1, 2, ease"
          "workspaces, 1, 5, overshot, slide"
        ];
      };
      
      # === LAYER RULES (ViegPhunt style) ===
      layerrule = [
        "blur, waybar"
        "blur, logout_dialog"
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];
      
      # === WINDOW RULES (ViegPhunt style) ===
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
      
      windowrule = [
        "noblur, xwayland:1, floating:1"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # === ENHANCED KEYBINDINGS (ViegPhunt style) ===
      "$mainMod" = "SUPER";
      
      bind = [
        # === BASIC CONTROLS ===
        "$mainMod, Space, exec, ghostty"              # Terminal (ViegPhunt uses Space)
        "$mainMod, Q, killactive,"                    # Close window
        "$mainMod SHIFT, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill" # Force kill
        "$mainMod SHIFT CTRL, Escape, exit,"          # Exit Hyprland
        "$mainMod, E, exec, nemo"                     # File manager
        "$mainMod, B, exec, firefox"                  # Browser (Firefox instead of Brave)
        "$mainMod, F, togglefloating,"                # Toggle floating
        "ALT, Space, exec, rofi -show drun"           # App launcher
        "$mainMod, V, exec, cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy" # Clipboard
        
        # === SCREENSHOTS ===
        "$mainMod SHIFT, S, exec, hyprshot -m region -o ~/Pictures/Screenshots" # Screenshot region
        ", Print, exec, hyprshot -m output -o ~/Pictures/Screenshots"           # Screenshot full
        
        # === EMOJI & SPECIAL ===
        "$mainMod, PERIOD, exec, rofi -show emoji"    # Emoji picker
        
        # === WALLPAPER CONTROLS (ViegPhunt style) ===
        "$mainMod, W, exec, ~/.config/viegphunt/wallpaper_select.sh"     # Select wallpaper
        "$mainMod SHIFT, W, exec, ~/.config/viegphunt/wallpaper_random.sh" # Random wallpaper
        
        # === WINDOW NAVIGATION ===
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r" 
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        
        # === WINDOW MANAGEMENT ===
        "$mainMod, P, pseudo,"                        # Pseudotile
        "$mainMod, J, togglesplit,"                   # Toggle split
        "$mainMod SHIFT, F, fullscreen,"              # Fullscreen
        
        # === WORKSPACES ===
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        
        # === MOVE TO WORKSPACE ===
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        
        # === SPECIAL WORKSPACE ===
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];

      # === MOUSE BINDINGS ===
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      
      # === MEDIA KEYS (ViegPhunt style) ===
      bindl = [
        # Volume and brightness controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        
        # Media controls (requires playerctl)
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # === AUTOSTART (ViegPhunt style) ===
      exec-once = [
        "waybar"                                      # Status bar
        "swaync"                                      # Notification center
        "swww-daemon & sleep 0.5 & swww init"        # Wallpaper daemon with init
        "nm-applet --indicator"                       # Network applet
        
        # === FCITX5 SETUP ===
        "export GTK_IM_MODULE=fcitx5"
        "export QT_IM_MODULE=fcitx5"
        "export XMODIFIERS=@im=fcitx5"
        "export INPUT_METHOD=fcitx5"
        "export SDL_IM_MODULE=fcitx5"
        "fcitx5"
        
        # === SCREEN SHARING ===
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        
        # === CLIPBOARD SETUP ===
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        
        # === THEMES SETUP ===
        "~/.config/viegphunt/gtkthemes.sh"
      ];

      # === ENVIRONMENT VARIABLES (ViegPhunt style) ===
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];
    };
  };
} 