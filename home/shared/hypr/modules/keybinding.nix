# ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ 
# ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ 
# █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗
# ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║
# ██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝
# ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
#-----------------------------------------------------------------------------


{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$altMod" = "ALT";
      "$shiftMod" = "SHIFT";
      "$controlMod" = "CTRL";

      bind = [
        "$controlMod $altMod, Delete, exec, hyprctl dispatch exit 0" # exit Hyprland
        "$altMod, Space, exec, $menu"
        "$mainMod, Space, exec, $terminal"
        "$mainMod SHIFT, Space, exec, [float; size 800 550] $terminal"
        "$mainMod, Q, killactive"
        "$mainMod Shift, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"
        "$mainMod Shift Control, Escape, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        # "$mainMod, F, togglefloating"
        "$mainMod, F, fullscreen"
        # "$mainMod, C, exec, hyprpicker -a"
        "$mainMod, C, exec, $codeEditor"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, H, exec, pkill -SIGUSR1 waybar" # Hide Waybar
        "$mainMod SHIFT, E, exec, kitty yazi" # Yazi File Manager
        "$mainMod Shift, S, exec, hyprshot -m region -o $HOME/Pictures/Screenshots"
        "$mainMod, PERIOD, exec, rofi -show emoji" # Select emoji
        "$mainMod, V, exec, cliphist list | rofi -dmenu -p \"Clipboard\" | cliphist decode | wl-copy"
        "$mainMod, R, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/wbrestart.sh"
        "$mainMod, L, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/hyprlock.sh"
        "$mainMod SHIFT, L, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/wlogout.sh"
        # "$mainMod SHIFT, S, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/screenshot.sh"
        "$mainMod, W, exec, ~/Workspaces/Config/nixos/home/shared/matugen/scripts/wppicker.sh"
        "$mainMod SHIFT, Q, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/kill-active-process.sh"
        # "$mainMod CTRL, B, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-styles.sh" # Waybar Styles Menu
        # "$mainMod ALT, B, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-layout.sh" # Waybar Layout Menu
        "$mainMod SHIFT, W, exec, matugen-apply $(cat ~/Workspaces/Config/nixos/current_wallpaper)"
        "$mainMod SHIFT, R, exec, matugen-apply" # Sẽ prompt chọn wallpaper
        
        "$mainMod, left, movefocus, h"
        "$mainMod, right, movefocus, l"
        "$mainMod, up, movefocus, k"
        "$mainMod, down, movefocus, j"
        
        
        "$mainMod CTRL, left, movewindow, h"
        "$mainMod CTRL, right, movewindow, l"
        "$mainMod CTRL, up, movewindow, k"
        "$mainMod CTRL, down, movewindow, j"
        
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

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Resize window
      binde = [
        "$mainMod SHIFT, left, resizeactive,-50 0"
        "$mainMod SHIFT, right, resizeactive,50 0"
        "$mainMod SHIFT, up, resizeactive,0 -50"
        "$mainMod SHIFT, down, resizeactive,0 50"
      ];

      # Move window
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc"
        ", XF86AudioLowerVolume, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec"
        ", XF86AudioMute, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/brightness.sh --inc"
        ", XF86MonBrightnessDown, exec, ~/Workspaces/Config/nixos/home/shared/hypr/scripts/brightness.sh --dec"
      ];
    };
  };
}
