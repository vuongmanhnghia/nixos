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
        
        # Input method setup - QUAN TRỌNG: Khởi động fcitx5 trước
        "${pkgs.fcitx5}/bin/fcitx5 -d --replace"
        "sleep 2"  # Đợi fcitx5 khởi động hoàn toàn
        
        # Fcitx5 configuration with unikey - Sử dụng script từ thư mục scripts
        "~//Workspaces/Config/nixos/home/shared/hypr/autostart.nix"
        "sleep 1"  # Đợi script cấu hình hoàn thành
        
        # Restart fcitx5 để áp dụng cấu hình mới
        "${pkgs.fcitx5}/bin/fcitx5-remote -r"
        
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
    fcitx5
    fcitx5-configtool
    fcitx5-gtk
    fcitx5-unikey
    wl-clipboard
    cliphist
  ];
}