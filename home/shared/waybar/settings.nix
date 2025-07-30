# waybar/settings.nix - Main bar configuration
{ config, pkgs, lib, ... }:

{
  options.waybar.customSettings = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.waybar.customSettings = {
    # Main bar configuration
    mainBar = {
      # === BAR LAYOUT ===
      layer = "bottom";
      exclusive = true;
      passthrough = false;
      position = "top";
      spacing = 3;
      fixed-center = true;
      ipc = true;
      margin-top = 3;
      margin-left = 8;
      margin-right = 8;

      # === MODULE LAYOUT ===
      modules-left = [
        "clock"
        "custom/separator#blank"
        "hyprland/workspaces#rw"
      ];
      
      modules-center = [
        "mpris"
      ];
      
      modules-right = [
        "group/notify"
        "battery"
        "custom/separator#blank"
        "group/audio"
        "custom/separator#blank"
        "custom/power"
      ];

      # === IMPORT MODULE CONFIGURATIONS ===
      # System modules
      inherit (config.waybar.modules.system) 
        temperature
        backlight
        battery
        cpu
        disk
        memory
        power-profiles-daemon
      ;
      
      # Hyprland modules  
      inherit (config.waybar.modules.hyprland)
        "hyprland/workspaces" 
        "hyprland/workspaces#rw"
        "hyprland/workspaces#roman"
        "hyprland/workspaces#pacman"
        "hyprland/workspaces#kanji"
        "hyprland/workspaces#cam"
        "hyprland/workspaces#numbers"
        "hyprland/workspaces#alpha"
        "hyprland/language"
        "hyprland/submap"
        "hyprland/window"
      ;
      
      # Audio modules
      inherit (config.waybar.modules.audio)
        pulseaudio
        "pulseaudio#microphone"
        wireplumber
      ;
      
      # Network modules
      inherit (config.waybar.modules.network)
        network
        "network#speed"
        bluetooth
      ;

      # Media modules
      inherit (config.waybar.modules.media)
        mpris
      ;
      
      # Custom modules
      inherit (config.waybar.modules.custom)
        "custom/weather"
        "custom/file_manager"
        "custom/tty"
        "custom/browser"
        "custom/settings"
        "custom/cycle_wall" 
        "custom/hint"
        "custom/dot_update"
        "custom/hypridle"
        "custom/keyboard"
        "custom/light_dark"
        "custom/lock"
        "custom/menu" 
        "custom/cava_mviz"
        "custom/playerctl"
        "custom/power"
        "custom/reboot"
        "custom/quit"
        "custom/swaync"
        "custom/updater"
      ;
      
      # Separator modules
      inherit (config.waybar.modules.separators)
        "custom/separator#dot"
        "custom/separator#dot-line"
        "custom/separator#line"
        "custom/separator#blank"
        "custom/separator#blank_2"
        "custom/separator#blank_3"
        "custom/arrow1"
        "custom/arrow2"
        "custom/arrow3"
        "custom/arrow4"
        "custom/arrow5"
        "custom/arrow6"
        "custom/arrow7"
        "custom/arrow8"
        "custom/arrow9"
        "custom/arrow10"
      ;
      
      # Group modules
      inherit (config.waybar.modules.groups)
        "group/app_drawer"
        "group/motherboard"
        "group/mobo_drawer"
        "group/laptop"
        "group/audio"
        "group/connections"
        "group/status"
        "group/notify"
        "group/power"
      ;
      
      # Other modules
      inherit (config.waybar.modules.other)
        clock
        idle_inhibitor
        keyboard-state
        tray
        "wlr/taskbar"
      ;
    };
  };
}