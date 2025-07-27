# SwayNC configuration for NixOS
# Add this to your home-manager configuration

{ config, pkgs, ... }:

{
  services.swaync = {
    enable = true;
    
    # Main configuration
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      "positionX" = "right";
      "positionY" = "top";
      "layer" = "overlay";
      "control-center-layer" = "top";
      "layer-shell" = true;
      "cssPriority" = "user";
      "control-center-margin-top" = 5;
      "control-center-margin-bottom" = 0;
      "control-center-margin-right" = 0;
      "control-center-margin-left" = 0;
      "notification-2fa-action" = true;
      "notification-inline-replies" = false;
      "notification-icon-size" = 24;
      "notification-body-image-height" = 100;
      "notification-body-image-width" = 100;
      "notification-window-width" = 300;
      "timeout" = 6;
      "timeout-low" = 3;
      "timeout-critical" = 0;
      "fit-to-screen" = false;
      "control-center-width" = 380;
      "control-center-height" = 800;
      "keyboard-shortcuts" = true;
      "image-visibility" = "when available";
      "transition-time" = 200;
      "hide-on-clear" = false;
      "hide-on-action" = true;
      "script-fail-notify" = true;
      
      "widgets" = [
        "buttons-grid"
        "mpris"
        "dnd"
        "title"
        "notifications"
      ];
      
      "widget-config" = {
        "title" = {
          "text" = "Notifications";
          "clear-all-button" = true;
          "button-text" = "󰎟";
        };
        "backlight" = {
          "label" = "󰃟";
        };
        "dnd" = {
          "text" = "Do Not Disturb";
        };
        "label" = {
          "max-lines" = 1;
          "text" = "Notification";
        };
        "mpris" = {
          "image-size" = 50;
          "image-radius" = 12;
        };
        "buttons-grid" = {
          "actions" = [
            {
              "label" = "󰐥";
              "command" = "bash -c ~/Workspaces/Config/nixos/home/shared/hypr/scripts/wlogout.sh";
            }
            {
              "label" = "󰌾";
              "command" = "bash -c ~/Workspaces/Config/nixos/home/shared/hypr/scripts/hyprlock.sh";
            }
            {
              "label" = "󰍃";
              "command" = "hyprctl dispatch exit";
            }
            {
              "label" = "󰀝";
              "command" = "bash -c ~/Workspaces/Config/nixos/home/shared/hypr/scripts/airplane-mode.sh";
            }
            {
              "label" = "󰝟";
              "command" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            }
          ];
        };
      };
    };

    # CSS styling
    style = ''
      @import '/home/nagih/Workspaces/Config/nixos/colors/swaync.css';

      /* Control Center Styles */
      @define-color text            @on_surface;
      @define-color background-alt  alpha(@color1, .4);
      @define-color selected        @outline;
      @define-color hover           alpha(@selected, 1);
      @define-color urgent          @error;

      * {
        color:            @text;
        all: unset;
        font-size: 14px;
        font-family: "JetBrains Mono Nerd Font";
        transition: 200ms;
      }

      /* Avoid 'annoying' background */
      .blank-window {  
        background: transparent;  
      }
        
      /* CONTROL CENTER ------------------------------------------------------------------------ */

      .control-center {
        background-color: rgba(0, 0, 0, 0.6);
        border-radius: 24px;
        border: 1px solid @selected;
        box-shadow: 0 0 10px 0 rgba(0,0,0,.6);
        margin: 10px 14px;
        padding: 12px 18px;
      }

      /* Notifications  */
      .control-center .notification-row .notification-background,
      .control-center .notification-row .notification-background .notification.critical {
        background-color: @on_secondary_fixed;
        border: 1px solid @hover;
        border-radius: 16px;
        margin: 4px 0px;
        padding: 4px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        color: @urgent;
      }

      .control-center .notification-row .notification-background .notification .notification-content {
        margin: 6px;
        padding: 6px 6px 2px 2px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
        background: alpha(@selected, .6);
        color: @text;
        border-radius: 12px;
        margin: 6px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        background: @selected;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: @selected;
      }

      /* Buttons */
      .control-center .notification-row .notification-background .close-button {
        background: transparent;
        border-radius: 6px;
        color: @text;
        padding: 4px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: @selected;
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: @selected;
      }

      progressbar,
      progress,
      trough {
        border-radius: 12px;
      }

      progressbar {
        background-color: rgba(255,255,255,.1);
      }

      /* Notifications expanded-group */
      .notification-group {
        margin: 2px 8px 2px 8px;
      }

      .notification-group-headers {
        font-weight: bold;
        font-size: 1.25rem;
        color: @text;
        letter-spacing: 2px;
      }

      .notification-group-icon {
        color: @text;
      }

      .notification-group-collapse-button,
      .notification-group-close-all-button {
        background: transparent;
        color: @text;
        margin: 4px; 
        border-radius: 6px;
        padding: 4px;
      }

      .notification-group-collapse-button:hover,
      .notification-group-close-all-button:hover {
        background: @hover;
      }  

      /* WIDGETS --------------------------------------------------------------------------- */

      /* Notification clear button */
      .widget-title {
        font-size: 1.2em;
        margin: 6px 0px;
      }

      .widget-title button {
        background: alpha(@hover, .50);
        border-radius: 6px;
        padding: 4px 16px;
      }

      .widget-title button:hover {
        background-color: @hover;
      }

      .widget-title button:active {
        background-color: @selected;
      }

      /* Do not disturb */
      .widget-dnd {
        margin: 6px 0px;
        font-size: 1.2rem;
      }

      .widget-dnd > switch {
        background: alpha(@hover, .50);
        font-size: initial;
        border-radius: 8px;
        box-shadow: none;
        padding: 2px;
      }

      .widget-dnd > switch:hover {
        background: @hover;
      }

      .widget-dnd > switch:checked {
        background: @selected;
      }

      .widget-dnd > switch:checked:hover {
        background: @hover;
      }

      .widget-dnd > switch slider {
        background: @text;
        border-radius: 6px;
      }

      /* === Buttons menu === */
      .widget-buttons-grid {
        font-size: x-large;
        padding: 6px 2px;
        margin: 6px 0px;
        border-radius: 12px;
        background: alpha(@hover, .50);
      }

      .widget-buttons-grid>flowbox>flowboxchild>button {
        margin: 4px 10px;
        padding: 6px 12px;
        background: transparent;
        border-radius: 8px;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: @hover;
      }

      /* Music player */
      .widget-mpris {
        background: alpha(@hover, .50);
        border-radius: 16px;
        color: @text;
        margin:  20px 0;
        padding: 12px 4px 4px 4px;
      }

      /* NOTE: Background need *opacity 1* otherwise will turn into the album art blurred  */
      .widget-mpris-player {
        background-color: rgba(0, 0, 0, 0.6);
        border-radius: 14px;
        padding: 6px 14px;
        margin: 4px;
      }

      .widget-mpris > box > button {
        color: @text;
        border-radius: 20px;
      }
       
      .widget-mpris button {
        color: alpha(@text, .6);
      }

      .widget-mpris button:hover {
        color: @text;
      }

      .widget-mpris-album-art {
        border-radius: 12px;
        margin: 6px 2px;
      }
       
      .widget-mpris-title {
          font-weight: 700;
          font-size: 1rem;
      }
       
      .widget-mpris-subtitle {
          font-weight: 500;
          font-size: 0.8rem;
      }

      /* Volume */
      .widget-volume {
        background: @background-sec;
        color: @background;
        padding: 4px;
        margin: 6px;
        border-radius: 6px;
      }

      /* FLOATING NOTIFICATIONS STYLES */
      @define-color text            @inverse_surface;
      @define-color background-alt  @background;
      @define-color selected        @on_secondary;
      @define-color hover           @on_secondary_fixed_variant;
      @define-color urgent          @on_secondary_fixed;

      .notification-row {
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .floating-notifications.background .notification-row .notification-background {
        background-color: rgba(0, 0, 0, 0.5);
        box-shadow: 0 0 8px 0 rgba(0,0,0,.6);
        border: 1px solid @selected;
        border-radius: 24px;
        margin: 16px;
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 6px;
        border-radius: 12px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        border: 2px solid @urgent;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 14px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 8px;
        background-color: @background-alt ;
        margin: 6px;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        background-color: @hover;
        border: 1px solid @selected;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: @selected;
        color: @background;
      }

      .image {
        margin: 10px 20px 10px 0px;
        border-radius: 10px;
      }

      .summary {
        font-weight: 800;
        font-size: 1rem;
      }

      .body {
        font-size: 0.8rem;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 6px;
        padding: 2px;
        border-radius: 6px;
        background-color: transparent;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: @selected;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: @selected;
        color: @background;
      }

      .notification.critical progress {
        background-color: @error;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @hover;
      }
    '';
  };
}