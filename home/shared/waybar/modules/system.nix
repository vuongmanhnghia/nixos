# waybar/modules/system.nix - System-related modules
{ config, pkgs, lib, ... }:

{
  config.waybar.modules.system = {
    # === TEMPERATURE MODULE ===
    temperature = {
      interval = 10;
      tooltip = true;
      hwmon-path = [
        "/sys/class/hwmon/hwmon1/temp1_input"
        "/sys/class/thermal/thermal_zone0/temp"
      ];
      critical-threshold = 82;
      format-critical = "{temperatureC}°C {icon}";
      format = "{temperatureC}°C {icon}";
      format-icons = ["󰈸"];
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --nvtop";
    };

    # === BACKLIGHT MODULE ===
    backlight = {
      interval = 2;
      align = 0;
      rotate = 0;
      format-icons = [
        " "
        " "
        " "
        "󰃝 "
        "󰃞 "
        "󰃟 "
        "󰃠 "
      ];
      format = "{icon}";
      tooltip-format = "backlight {percent}%";
      icon-size = 10;
      on-click = "";
      on-click-middle = "";
      on-click-right = "";
      on-update = "";
      on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/brightness.sh --inc";
      on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/brightness.sh --dec";
      smooth-scrolling-threshold = 1;
    };

    # === BATTERY MODULE ===
    battery = {
      align = 0;
      rotate = 0;
      full-at = 100;
      design-capacity = false;
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-charging = " {capacity}%";
      format-plugged = "󱘖 {capacity}%";
      format-alt-click = "click";
      format-full = "{icon} Full";
      format-alt = "{icon} {time}";
      format-icons = [
        "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
      ];
      format-time = "{H}h {M}min";
      tooltip = true;
      tooltip-format = "{timeTo} {power}w";
      on-click-middle = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/change-blur.sh";
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/wlogout.sh";
    };

    # === CPU MODULE ===
    cpu = {
      format = "{usage}% 󰍛";
      interval = 1;
      min-length = 5;
      format-alt-click = "click";
      format-alt = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
      format-icons = [
        "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"
      ];
      on-click-right = "gnome-system-monitor";
    };

    # === DISK MODULE ===
    disk = {
      interval = 30;
      path = "/";
      format = "{percentage_used}% 󰋊";
      tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
    };

    # === MEMORY MODULE ===
    memory = {
      interval = 10;
      format = "{used:0.1f}G 󰾆";
      format-alt = "{percentage}% 󰾆";
      format-alt-click = "click";
      tooltip = true;
      tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --btop";
    };

    # === POWER PROFILES MODULE ===
    power-profiles-daemon = {
      format = "{icon} ";
      tooltip-format = "Power profile: {profile}\nDriver: {driver}";
      tooltip = true;
      format-icons = {
        default = "";
        performance = "";
        balanced = "";
        power-saver = "";
      };
    };
  };
}