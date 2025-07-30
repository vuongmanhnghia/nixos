#  █████╗ ██╗   ██╗████████╗ ██████╗ ███████╗████████╗ █████╗ ██████╗ ████████╗
# ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝
# ███████║██║   ██║   ██║   ██║   ██║███████╗   ██║   ███████║██████╔╝   ██║   
# ██╔══██║██║   ██║   ██║   ██║   ██║╚════██║   ██║   ██╔══██║██╔══██╗   ██║   
# ██║  ██║╚██████╔╝   ██║   ╚██████╔╝███████║   ██║   ██║  ██║██║  ██║   ██║   
# ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
#------------------------------------------------------------------------------

{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {    
    settings = {
      exec-once = [
        # Network management
        "${pkgs.networkmanagerapplet}/bin/nm-applet"
        
        # Status bar
        "${pkgs.waybar}/bin/waybar"
        
        # Wallpaper daemon
        "${pkgs.swww}/bin/swww-daemon"
        
        # Bluetooth applet
        "${pkgs.blueman}/bin/blueman-applet"
        
        # Polkit agent
        "systemctl --user start hyprpolkitagent"
        
        # Idle daemon
        "${pkgs.hypridle}/bin/hypridle"
        
        # Notification center
        "${pkgs.swaynotificationcenter}/bin/swaync"
        
        # Screen sharing setup
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd XMODIFIERS GTK_IM_MODULE QT_IM_MODULE SDL_IM_MODULE"
        
        # Clipboard management
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
        
        # GTK themes (custom script)
        "~/.config/viegphunt/gtkthemes.sh"

        # Matugen
        "~/.config/matugen/scripts/matugen-apply $(cat ~/Workspaces/Config/nixos/current_wallpaper)"

        # Setup fcitx5
        "export GTK_IM_MODULE=fcitx5"
        "export QT_IM_MODULE=fcitx5"
        "export XMODIFIERS=@im=fcitx5"
        "export INPUT_METHOD=fcitx5"
        "export SDL_IM_MODULE=fcitx5"
        "fcitx5"
      ];
    };
  };

  # Install required packages
  home.packages = with pkgs; [
    networkmanagerapplet
    waybar
    swww
    blueman
    hypridle
    swaynotificationcenter
    wl-clipboard
    cliphist
  ];
}