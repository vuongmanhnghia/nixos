# ███╗   ███╗██╗███████╗ ██████╗
# ████╗ ████║██║██╔════╝██╔════╝
# ██╔████╔██║██║███████╗██║     
# ██║╚██╔╝██║██║╚════██║██║     
# ██║ ╚═╝ ██║██║███████║╚██████╗
# ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝
#-------------------------------


{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      misc = {
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot Wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        vfr = true; # save resources
        disable_splash_rendering = true;
        initial_workspace_tracking = 0;
      };
    };
  };
}
