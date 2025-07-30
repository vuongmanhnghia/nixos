{ config, lib, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = "colors.conf";
      "$Scripts" = "~/Workspaces/Config/nixos/home/shared/hypr/scripts";

      general = {
        grace = 1;
        fractional_scaling = 2;
        immediate_render = true;
      };

      background = [
        {
          monitor = "";
          # NOTE: use only 1 path
          # path = "screenshot";   # screenshot of your desktop
          # path = "~/Workspaces/Config/nixos/home/shared/hypr/wallpaper_effects/.wallpaper_modified"; # by wallpaper effects
          path = "/home/nagih/Workspaces/Config/nixos/current_wallpaper"; # CURRENT WALLPAPER
          
          color = "rgb(0,0,0)"; # color will be rendered initially until path is available

          # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
          blur_size = 3;
          blur_passes = 2; # 0 disables blurring
          noise = 0.0117;
          contrast = 1.3000; # Vibrant!!!
          brightness = 0.6000;
          vibrancy = 0.2100;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;

          dots_size = 0.26; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          dots_rounding = -1;

          rounding = 22;
          outer_color = "$source_color";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "$secondary";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>"; # Text rendered in the input box when it's empty.

          position = "0, 120";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        # Minutes
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b><big> $(date +\"%M\") </big></b>\"";
          color = "$on_secondary_container";
          font_size = 112;
          font_family = "Adwaita Sans";
          shadow_passes = 0;
          shadow_size = 0;

          position = "0, 80";
          halign = "center";
          valign = "center";
        }

        # Today
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
          color = "$secondary";
          font_size = 18;
          font_family = "JetBrainsMono NFM";

          position = "0, -15";
          halign = "center";
          valign = "center";
        }

        # Week
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b> \"$(date +'%d %b')\" </b>\"";
          color = "$secondary";
          font_size = 14;
          font_family = "JetBrainsMono Nerd Font 10";

          position = "0, -40";
          halign = "center";
          valign = "center";
        }

        # Degrees
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b>Feels like<big> $(curl -s 'wttr.in?format=%t' | tr -d '+') </big></b>\"";
          color = "$color8";
          font_size = 14;
          font_family = "JetBrainsMono NFM";

          position = "0, 40";
          halign = "center";
          valign = "bottom";
        }

        # USER
        {
          monitor = "";
          text = "$USER";
          color = "$color8";
          font_size = 14;
          font_family = "JetBrainsMono NFM Bold";
          position = "0, 200";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}