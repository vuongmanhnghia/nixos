# matugen/config.nix - Config chính cho matugen
{ config, pkgs, lib, ... }:

{
  # Create matugen config directory and files
  home.file = {
    # Main configuration file
    ".config/matugen/config.toml".text = ''
      [config.wallpaper]
      command = "swww"
      arguments = ["img", "--transition-type", "any", "--transition-fps", "180"]
      set = true

      [templates.waybar]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/colors.css'
      output_path = '~/Workspaces/Config/nixos/colors/waybar.css'
      post_hook = 'pkill -SIGUSR2 waybar'

      [templates.swaync]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/colors.css'
      output_path = '~/Workspaces/Config/nixos/colors/swaync.css'
      post_hook = 'pkill -SIGUSR2 swaync'

      [templates.kitty]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/kitty.conf'
      output_path = '~/Workspaces/Config/nixos/colors/kitty.conf'
      post_hook = "kill -SIGUSR1 $(pidof kitty)"

      [templates.hyprland]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/hyprland.conf'
      output_path = '~/Workspaces/Config/nixos/colors/hypr.conf'
      post_hook = 'hyprctl reload'

      [templates.gtk3]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/gtk.css'
      output_path = '~/Workspaces/Config/nixos/colors/gtk.css'

      [templates.gtk4]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/gtk.css'
      output_path = '~/Workspaces/Config/nixos/colors/gtk.css'

      [templates.rofi]
      input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/rofi.rasi'
      output_path = '~/Workspaces/Config/nixos/colors/rofi.rasi'

      # [templates.cava]
      # input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/cava'
      # output_path = '~/Workspaces/Config/nixos/colors/cava.config'
      # post_hook = "pkill -SIGUSR2 cava"

      # [templates.spicetify]
      # input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/spotify.ini'
      # output_path = '~/Workspaces/Config/nixos/colors/spotify.ini'

      # [templates.vesktop]
      # input_path = '~/Workspaces/Config/nixos/home/shared/matugen/templates/midnight-discord.css'
      # output_path = '~/Workspaces/Config/nixos/colors/vesktop.css'
    '';

    # Các template được đọc từ file riêng
    ".config/matugen/templates/colors.css".source = ../templates/colors.css;
    ".config/matugen/templates/gtk.css".source = ../templates/gtk.css;
    ".config/matugen/templates/hyprland.conf".source = ../templates/hyprland.conf;
    ".config/matugen/templates/kitty.conf".source = ../templates/kitty.conf;
    ".config/matugen/templates/rofi.rasi".source = ../templates/rofi.rasi;
    ".config/matugen/templates/cava".source = ../templates/cava;
    # ".config/matugen/templates/spotify.ini".source = ../templates/spotify.ini;
  };
}