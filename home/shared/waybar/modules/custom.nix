{ config, pkgs, lib, ... }:
{
  config.waybar.modules.custom = {
    # Custom modules
    "custom/weather" = {
      format = "{}";
      format-alt = "{alt}: {}";
      format-alt-click = "click";
      interval = 3600;
      return-type = "json";
      exec = "$HOME/.config/hypr/UserScripts/Weather.py";
      tooltip = true;
    };

    "custom/file_manager" = {
      format = " ";
      on-click = "xdg-open . &";
      tooltip = true;
      tooltip-format = "File Manager";
    };

    "custom/tty" = {
      format = " ";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --term";
      tooltip = true;
      tooltip-format = "Launch Terminal";
    };

    "custom/browser" = {
      format = " ";
      on-click = "xdg-open https://";
      tooltip = true;
      tooltip-format = "Launch Browser";
    };

    "custom/settings" = {
      format = " ";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/Kool_Quick_Settings.sh";
      tooltip = true;
      tooltip-format = "Launch KooL Hyprland Settings Menu";
    };

    "custom/cycle_wall" = {
      format = " ";
      on-click = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
      on-click-right = "$HOME/.config/hypr/UserScripts/WallpaperRandom.sh";
      on-click-middle = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-styles.sh";
      tooltip = true;
      tooltip-format = "Left Click: Wallpaper Menu\nMiddle Click: Random wallpaper\nRight Click: Waybar Styles Menu";
    };

    "custom/hint" = {
      format = "󰺁 HINT!";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/key-hints.sh";
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/key-binds.sh";
      tooltip = true;
      tooltip-format = "Left Click: Quick Tips\nRight Click: Keybinds";
    };

    "custom/dot_update" = {
      format = " 󰁈 ";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/KooLsDotsUpdate.sh";
      tooltip = true;
      tooltip-format = "Check KooL Dots update\nIf available";
    };

    # hypridle inhibitor
    "custom/hypridle" = {
      format = "󱫗 ";
      return-type = "json";
      escape = true;
      exec-on-event = true;
      interval = 60;
      exec = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/hypridle.sh status";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/hypridle.sh toggle";
      on-click-right = "hyprlock";
    };

    "custom/keyboard" = {
      exec = "cat $HOME/.cache/kb_layout";
      interval = 1;
      format = " {}";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/switch-keyboard-layout.sh";
    };

    "custom/light_dark" = {
      format = "󰔎 ";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/dark-light.sh";
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-styles.sh";
      on-click-middle = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
      tooltip = true;
      tooltip-format = "Left Click: Switch Dark-Light Themes\nMiddle Click: Wallpaper Menu\nRight Click: Waybar Styles Menu";
    };

    "custom/lock" = {
      format = "󰌾";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/LockScreen.sh";
      tooltip = true;
      tooltip-format = "󰷛 Screen Lock";
    };

    "custom/menu" = {
      format = "  ";
      on-click = "pkill rofi || rofi -show drun -modi run,drun,filebrowser,window";
      on-click-middle = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-layout.sh";
      tooltip = true;
      tooltip-format = "Left Click: Rofi Menu\nMiddle Click: Wallpaper Menu\nRight Click: Waybar Layout Menu";
    };

    # Custom cava visualizer
    "custom/cava_mviz" = {
      exec = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybarcava.sh";
      format = "{}";
    };

    "custom/playerctl" = {
      format = "<span>{}</span>";
      return-type = "json";
      max-length = 25;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}}  {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click-middle = "playerctl play-pause";
      on-click = "playerctl previous";
      on-click-right = "playerctl next";
      scroll-step = 5.0;
      on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
      on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
      smooth-scrolling-threshold = 1;
    };

    "custom/power" = {
      format = "⏻";
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/wlogout.sh";
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/change-blur.sh";
      tooltip = true;
      tooltip-format = "Logout Menu";
    };

    "custom/reboot" = {
      format = "󰜉";
      on-click = "systemctl reboot";
      tooltip = true;
      tooltip-format = "Left Click: Reboot";
    };

    "custom/quit" = {
      format = "󰗼";
      on-click = "hyprctl dispatch exit";
      tooltip = true;
      tooltip-format = "Left Click: Exit Hyprland";
    };

    "custom/swaync" = {
      tooltip = true;
      tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
      format = " {} {icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "sleep 0.1 && swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };

    "custom/updater" = {
      format = " {}";
      exec = "checkupdates | wc -l";
      exec-if = "[[ $(checkupdates | wc -l) ]]";
      interval = 43200; # 12 hours interval
      on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/Distro_update.sh";
      tooltip = true;
      tooltip-format = "Left Click: Update System\nArch (w/ notification)\nFedora, OpenSuse, Debian/Ubuntu click to update";
    };
  };
}