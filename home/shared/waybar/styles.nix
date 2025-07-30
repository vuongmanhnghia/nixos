# waybar/styles.nix - CSS styling configuration
{ config, pkgs, lib, ... }:

{
  options.waybar.customStyles = lib.mkOption {
    type = lib.types.str;
    default = "";
  };

  config.waybar.customStyles = ''
    @import "/home/nagih/Workspaces/Config/nixos/colors/waybar.css";

    /* === FONT CONFIGURATION === */
    * {
      font-family: "JetBrainsMono Nerd Font Propo";
      font-weight: bold;
      min-height: 0;
      font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
    }

    /* === WINDOW STYLING === */
    window#waybar,
    window#waybar.empty,
    window#waybar.empty #window {
      background-color: transparent;
      padding: 0px;
      border: 0px;
    }

    /* === TOOLTIP STYLING === */
    tooltip {
      color: @inverse_surface;
      background: rgba(0, 0, 0, 0.8);
      border-radius: 20px;
    }

    tooltip label {
      color: @inverse_surface;
    }

    /* === MODULE GROUPS STYLING === */
    .modules-right,
    .modules-center,
    .modules-left {
      color: @secondary;
      padding: 2px 4px;
    }

    /* === WORKSPACES & TASKBAR STYLING === */
    #taskbar button,
    #workspaces button {
      color: @outline;
      box-shadow: none;
      text-shadow: none;
      padding: 1px 10px 0px;
      border-radius: 9px;
      margin: 0 4px;
      animation: gradient_f 20s ease-in infinite;
      transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
    }

    #taskbar button:hover,
    #workspaces button:hover {
      color: @primary;
      transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    }

    #taskbar button.active,
    #workspaces button.active {
      color: @background;
      background-color: alpha(@primary_fixed, 0.75);
      transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    }

    #workspaces button.urgent {
      color: @primary;
      border-radius: 10px;
    }

    #workspaces button.persistent {
      border-radius: 10px;
    }

    /* === NOTIFICATIONS === */
    #custom-swaync {
      background-color: alpha(@surface_container, 0.75);
      border-radius: 20px;
      padding: 8px;
      margin: 0 0 0 5px;
    }

    /* === MAIN MODULES STYLING === */
    #backlight,
    #backlight-slider,
    #battery,
    #bluetooth,
    #clock,
    #cpu,
    #disk,
    #idle_inhibitor,
    #keyboard-state,
    #memory,
    #mode,
    #mpris,
    #network,
    #power-profiles-daemon,
    #pulseaudio,
    #pulseaudio-slider,
    #taskbar,
    #temperature,
    #tray,
    #window,
    #wireplumber,
    #workspaces,
    #custom-backlight,
    #custom-browser,
    #custom-cava_mviz,
    #custom-cycle_wall,
    #custom-dot_update,
    #custom-file_manager,
    #custom-keybinds,
    #custom-keyboard,
    #custom-light_dark,
    #custom-lock,
    #custom-hint,
    #custom-hypridle,
    #custom-menu,
    #custom-playerctl,
    #custom-power_vertical,
    #custom-power,
    #custom-quit,
    #custom-reboot,
    #custom-settings,
    #custom-spotify,
    #custom-tty,
    #custom-updater,
    #custom-weather,
    #custom-weather.clearNight,
    #custom-weather.cloudyFoggyDay,
    #custom-weather.cloudyFoggyNight,
    #custom-weather.default, 
    #custom-weather.rainyDay,
    #custom-weather.rainyNight,
    #custom-weather.severe,
    #custom-weather.showyIcyDay,
    #custom-weather.snowyIcyNight,
    #custom-weather.sunnyDay {
      background-color: alpha(@surface_container, 0.75);
      border-radius: 20px;
      padding: 8px 15px;
      margin: 0 0 0 5px;
    }

    /* === STATUS INDICATORS === */
    #custom-hypridle.notactive,
    #idle_inhibitor.activated {
      color: #39FF14;
    }

    #pulseaudio.muted {
      color: #cc3436;
    }

    #temperature.critical {
      color: red;
    }

    #battery.critical:not(.charging) {
      color: #f53c3c;
    }

    /* === SLIDER STYLING === */
    #backlight-slider slider,
    #pulseaudio-slider slider {
      min-width: 0px;
      min-height: 0px;
      opacity: 0;
      background-image: none;
      border: none;
      box-shadow: none;
    }

    #backlight-slider trough,
    #pulseaudio-slider trough {
      min-width: 80px;
      min-height: 5px;
      border-radius: 5px;
    }

    #backlight-slider highlight,
    #pulseaudio-slider highlight {
      min-height: 10px;
      border-radius: 5px;
    }

    /* === ANIMATIONS === */
    @keyframes blink {
      to {
        color: #000000;
      }
    }

    @keyframes gradient_f {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }
  '';
}