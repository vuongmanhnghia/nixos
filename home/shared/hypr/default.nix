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
    ./animation.nix
    ./autostart.nix
    ./appearance.nix
    ./environment.nix
    ./input.nix
    ./keybinding.nix
    ./layout.nix
    ./misc.nix
    ./monitors.nix
    ./programs.nix
    ./tags.nix
    ./windowrule.nix
    ./workspaces.nix

    ./colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
}
