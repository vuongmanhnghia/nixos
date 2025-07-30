# ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗ 
# ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗
# ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║
# ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║
# ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ 
# -------------------------------------------------------------------


{ config, pkgs, ... }:

{
  imports = [
    ./modules/animation.nix
    ./modules/autostart.nix
    ./modules/appearance.nix
    ./modules/environment.nix
    ./modules/input.nix
    ./modules/keybinding.nix
    ./modules/layout.nix
    ./modules/misc.nix
    ./modules/monitors.nix
    ./modules/programs.nix
    ./modules/tags.nix
    ./modules/windowrule.nix
    ./modules/workspaces.nix
    ./modules/colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
}
