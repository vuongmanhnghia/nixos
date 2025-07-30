{ config, pkgs, lib, ... }:
{
  config.waybar.modules.other = {
    clock = {
      interval = 1;
      format = " {:%I:%M %p}"; # AM PM format
      format-alt = " {:%H:%M   %Y, %d %B, %A}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
      actions = {
        on-click-right = "mode";
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };

    idle_inhibitor = {
      tooltip = true;
      tooltip-format-activated = "Idle_inhibitor active";
      tooltip-format-deactivated = "Idle_inhibitor not active";
      format = "{icon}";
      format-icons = {
        activated = " ";
        deactivated = " ";
      };
    };

    keyboard-state = {
      capslock = true;
      format = {
        numlock = "N {icon}";
        capslock = "󰪛 {icon}";
      };
      format-icons = {
        locked = "";
        unlocked = "";
      };
    };

    tray = {
      icon-size = 20;
      spacing = 4;
    };

    "wlr/taskbar" = {
      format = "{icon} {name}";
      icon-size = 16;
      all-outputs = false;
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = [
        "wofi" "rofi" "kitty" "kitty-dropterm"
      ];
    };
  };
}