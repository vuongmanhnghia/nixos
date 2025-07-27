{ config, pkgs, ... }:

{
  # === WAYBAR CONFIGURATION (ViegPhunt Style) ===
  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        # === MAIN BAR CONFIGURATION ===
        "modules-left" = [ "custom/power" "hyprland/workspaces" ];
        "modules-right" = [ "tray" "bluetooth" "network" "battery" "pulseaudio" "clock" ];
        
        # === LEFT MODULES ===
        "custom/power" = {
          format = "⭘ ";
          tooltip = false;
          "on-click" = "wlogout -b 5";
        };
        
        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "warp-on-scroll" = false;
          format = "{name}";
          cursor = true;
        };
        
        # === RIGHT MODULES ===
        tray = {
          "icon-size" = 20;
          spacing = 10;
          cursor = true;
        };
        
        bluetooth = {
          format = " 󰂯 ";
          "format-disabled" = " 󰂲 ";
          "format-connected" = " 󰂱 ";
          "on-click" = "blueman-manager";
        };
        
        network = {
          "format-wifi" = "  {essid}";
          "format-ethernet" = "  Ethernet";
          "format-linked" = "  Linked (No IP)";
          "format-disconnected" = "  Disconnected";
          tooltip = false;
        };
        
        battery = {
          states = {
            good = 85;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-full" = "{icon} {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-charging" = " {capacity}%";
          "format-alt" = "{icon} {capacity}%";
          "format-icons" = [ " " " " " " " " " " ];
          "tooltip-format" = "{time}";
          cursor = false;
        };
        
        pulseaudio = {
          format = "{icon} {volume}%";
          "format-muted" = "  {volume}%";
          "format-bluetooth" = " {volume}%";
          "format-bluetooth-muted" = "  {volume}%";
          "format-icons" = {
            headphone = " ";
            headset = " ";
            default = [ " " ];
          };
          "on-click" = "pavucontrol";
        };
        
        clock = {
          format = "{:%a %d/%m/%Y ~ %H:%M}";
          "tooltip-format" = "<span size='15000'><tt>{calendar}</tt></span>";
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#F5C2E7'><b>{}</b></span>";
              weekdays = "<span color='#89B4FA'><b>{}</b></span>";
              days = "<span color='#CDD6F4'><b>{}</b></span>";
              today = "<span color='#F9E2AF'><b>{}</b></span>";
            };
          };
          "on-click" = "swaync-client -t -sw";
        };
      };
    };
    
    style = ''
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
          font-family: "JetBrainsMono Nerd Font";
          font-size: 13px;
          font-weight: bold;
          background-color: transparent;
          border-radius: 5px;
          min-height: 0;
      }
      
      window,
      tooltip {
          background-color: @background;
      }
      
      #waybar {
          background: alpha(@background, 0.6);
          border-radius: 0;
      }
      
      #workspaces {
          margin: 1px 0;
      }
      
      #workspaces button {
          color: @foreground;
          border: none;
          padding: 0 5px;
      }
      #workspaces button:hover {
          color: @pink;
          transition: none;
          border-bottom: 1px solid @pink;
          padding: 0 8px;
      }
      
      #workspaces button.active {
          color: @pink;
          border: 2px solid @pink;
          padding: 0 8px;
          margin: 0 2px;
      }
      
      #workspaces button.urgent {
          background-color: @red;
          padding: 0 8px;
      }
      
      #custom-power,
      #tray,
      #bluetooth,
      #network,
      #battery,
      #pulseaudio,
      #clock {
          color: @foreground;
          margin: 1px 0;
          padding: 0 10px;
      }
      
      #custom-power:hover,
      #bluetooth:hover,
      #network:hover,
      #battery:hover,
      #pulseaudio:hover,
      #clock:hover {
          background-color: alpha(@select, 0.6);
      }
      
      #bluetooth {
          color: @yellow;
      }
      
      #network {
          color: @green;
      }
      
      #battery {
          color: @purple;
      }
      
      #pulseaudio {
          color: @orange;
      }
      
      #clock {
          margin-right: 10px;
          color: @blue;
      }
      
      #custom-power {
          margin-left: 10px;
          padding: 0px 10px 0 15px;
      }
    '';
  };
} 