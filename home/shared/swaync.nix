{ config, pkgs, ... }:

{
  # === SWAYNC CONFIGURATION (ViegPhunt Style) ===
  
  # Create SwayNC configuration
  home.file.".config/swaync/config.json" = {
    text = ''
      {
          "$schema": "/etc/xdg/swaync/configSchema.json",
          "positionX": "right",
          "positionY": "top",
          "cssPriority": "user",
          
          "layer": "overlay",
          "control-center-layer": "top",
          "layer-shell": true,

          "control-center-width": 400,
          "control-center-height": 850,
          "control-center-margin-top": 10,
          "control-center-margin-bottom": 10,
          "control-center-margin-right": 10,
          "control-center-margin-left": 0,

          "notification-window-width": 380,
          "notification-icon-size": 50,
          "notification-body-image-height": 200,
          "notification-body-image-width": 200,

          "timeout": 8,
          "timeout-low": 6,
          "timeout-critical": 0,
       
          "fit-to-screen": false,
          "keyboard-shortcuts": true,
          "image-visibility": "when-available",
          "transition-time": 200,
          "hide-on-clear": false,
          "hide-on-action": true,
          "text-empty": "No Notifications",
          "script-fail-notify": true,
          "notification-visibility": {
              "example-name": {
                  "state": "muted",
                  "urgency": "Low",
                  "app-name": "Spotify"
              }
          },
          "widgets": [
              "buttons-grid",
              "mpris",
              "volume",
              "backlight",
              "dnd",
              "title",
              "notifications"
          ],
          "widget-config": {
              "mpris": {
                  "image-size": 50,
                  "image-radius": 0
              },
              "volume": {
                  "label": " 󰕾 ",
                  "expand-button-label": " ",
                  "collapse-button-label": " ",
                  "show-per-app": true,
                  "show-per-app-icon": true,
                  "show-per-app-label": false
              },
              "backlight": {
                  "label": "󰃟 "
              },
              "dnd": {
                  "text": "Do Not Disturb"
              },
              "title": {
                  "text": "Notifications Center",
                  "clear-all-button": true,
                  "button-text": " 󰆴 "
              },
              "buttons-grid": {
                  "actions": [
                      {
                          "label": " ",
                          "type": "toggle",
                          "active": true,
                          "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'",
                          "update-command": "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'"
                      },
                      {
                          "label": "󰂯",
                          "type": "toggle",
                          "active": true,
                          "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && rfkill unblock bluetooth || rfkill block bluetooth'",
                          "update-command": "sh -c \"rfkill list bluetooth | grep -q \"Soft blocked: no\" && echo true || echo false\""
                      },
                      {
                          "label": " ",
                          "type": "toggle",
                          "active": false,
                          "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-source-mute @DEFAULT_SOURCE@ 1 || pactl set-source-mute @DEFAULT_SOURCE@ 0'",
                          "update-command": "sh -c '[[ $(pactl get-source-mute @DEFAULT_SOURCE@) == *yes* ]] && echo true || echo false'"
                      },
                      {
                          "label": " ",
                          "type": "toggle",
                          "active": false,
                          "command": "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-sink-mute @DEFAULT_SINK@ 1 || pactl set-sink-mute @DEFAULT_SINK@ 0'",
                          "update-command": "sh -c '[[ $(pactl get-sink-mute @DEFAULT_SINK@) == *yes* ]] && echo true || echo false'"
                      }
                  ]
              }
          }
      }
    '';
  };
  
  # Create SwayNC style with Catppuccin colors
  home.file.".config/swaync/style.css" = {
    text = ''
      @define-color background #1e1e2e;
      @define-color foreground #cdd6f4;
      @define-color select     #585b70;
      
      @define-color pink       #f5c2e7;
      @define-color purple     #cba6f7;
      @define-color red        #f38ba8;
      @define-color orange     #fab387;
      @define-color yellow     #f9e2af;
      @define-color green      #a6e3a1;
      @define-color blue       #89b4fa;
      @define-color gray       #45475a;

      * {
          outline: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 18px;
          text-shadow: none;
          color: @foreground;
          background-color: transparent;
          background: transparent;
      }

      .control-center {
          background-color: alpha(@background, 0.8);
          box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.65);
          padding: 5px;
      }

      .control-center .notification-row .notification-background {
          border-radius: 15px;
          margin-top: 5px;
      }

      .notification {
          background-color: alpha(@background, 0.8);
      }

      .notification > *:last-child > *  {
          margin: 5px;
      }

      .summary { font-size: 1.1rem; }
      .time { font-size: 0.8rem; }
      .body { font-size: 1rem; }

      .notification-content {
          padding: 15px 10px 10px 20px;
      }

      .notification-action > button {
          padding: unset;
          margin: unset;
      }
      .notification-action > label {
          font-size: 1rem;
          font-weight: normal;
      }

      .notification.critical {
          background-color: alpha(#e64553, 0.5);
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.65);
      }
      .notification.low,
      .notification.normal  {
          background-color: alpha(@background, 0.5);
          box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.65);
      }

      .close-button {
          background-color: alpha(@gray, 0.8);
          box-shadow: 0 0 3px 0 rgba(0, 0, 0, 0.35);
      }
      .close-button:hover {
          background-color: alpha(@red, 0.8);
      }

      .notification-group-header,
      .notification-group-icon {
          font-size: 0.9rem;
      }

      .notification-group-collapse-button,
      .notification-group-close-all-button {
          box-shadow: 0 0 3px 0 rgba(0, 0, 0, 0.35);
          background-color: @gray;
      }

      .notification-group-collapse-button:hover {
          background-color: alpha(@blue, 0.8);
      }
      .notification-group-close-all-button:hover {
          background-color: alpha(@red, 0.8);
      }

      trough highlight {
          background: @blue;
      }
      scale trough {
          margin: 0rem 1rem;
          background-color: @gray;
          min-height: 8px;
          min-width: 70px;
      }
      slider {
          background-color: @foreground;
      }
      tooltip {
          background-color: @gray;
      }

      /*** Widgets ***/
      /* Buttons widget */
      .widget-buttons-grid {
          font-size: 1rem;
          padding: 20px 20px 10px;
          margin: unset;
      }
      .widget-buttons-grid > flowbox > flowboxchild > button {
          background: @gray;
          box-shadow: 0px 0px 10px alpha(@background, 0.8);
          border-radius: 12px;
          min-width: 60px;
          min-height: 30px;
          padding: 6px;
          margin: 0 3px 0;
          transition: all .5s ease;
      }
      .widget-buttons-grid > flowbox > flowboxchild > button:hover {
          background: @select;
      }
      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
          background: @blue;
      }
      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked:hover {
          background: alpha(@blue, 0.8);
      }

      /* Mpris widget */
      @define-color mpris-album-art-overlay rgba(0, 0, 0, 0.55);
      @define-color mpris-button-hover rgba(0, 0, 0, 0.5);

      .widget-mpris .widget-mpris-player {
          padding: 16px;
          margin: 16px 20px;
          background-color: @mpris-album-art-overlay;
          border-radius: 12px;
          box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.65);
      }
      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
          border-radius: 12px;
          box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.65);
      }
      .widget-mpris .widget-mpris-player .widget-mpris-title {
          font-weight: bold;
          font-size: 1.2rem;
          margin: 0px 8px 8px 8px;
      }
      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
          font-size: 1rem;
      }
      .widget-mpris .widget-mpris-player > box > button:hover {
          background-color: @mpris-button-hover;
      }
      .widget-mpris > box > button:hover {
          background: alpha(@select, 0.6);
      }

      /* Volume widget */
      .widget-volume {
          padding: 6px 5px 5px 5px;
          margin: unset;
          font-size: 1.3rem;
      }
      .widget-volume > box > button {
          border: none;
      }
      .per-app-volume {
          padding: 4px 8px 8px 8px;
          margin: 0px 8px 8px 8px;
      }

      /* Backlight widget */
      .widget-backlight {
          padding: 0 0 3px 16px;
          margin: unset;
          font-size: 1.1rem;
      }

      /* DND widget */
      .widget-dnd {
          font-weight: bold;
          margin: unset;
          padding: 20px 15px 15px 15px;
      }
      .widget-dnd > switch {
          font-size: initial;
          border-radius: 100px;
          background: @yellow;
          border: none;
          box-shadow: none;
          padding: 3px;
      }
      .widget-dnd > switch:checked {
          background: @green;
      }
      .widget-dnd > switch slider {
          background: @background;
          border-radius: 12px;
          min-width: 18px;
          min-height: 18px;
      }

      /* Title widget */
      .widget-title {
          padding: unset;
          margin: unset;
          font-weight: bold;
          padding: 15px;
      }
      .widget-title > label {
          font-size: 1.5rem;
      }
      .widget-title > button {
          padding:unset;
          margin:unset;
          text-shadow: none;
          background: #e64553;
          border: none;
          box-shadow: none;
          border-radius: 100px;
          padding:0px 6px;
          transition: all .7s ease;
      }
      .widget-title > button:hover {
          background: alpha(@red, 0.8);
          box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.65);
      }
    '';
  };
} 