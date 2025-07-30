# ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗██████╗ ██╗   ██╗██╗     ███████╗
# ██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔══██╗██║   ██║██║     ██╔════╝
# ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║██████╔╝██║   ██║██║     █████╗  
# ██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║██╔══██╗██║   ██║██║     ██╔══╝  
# ╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝██║  ██║╚██████╔╝███████╗███████╗
#  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
#------------------------------------------------------------------------------------



{ config, lib, pkgs, ... }:

{ 
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "noblur, tag:multimedia_video*"
        "opacity 1.0, tag:multimedia_video*"
        "opacity 0.8, tag:settings*"
        "opacity 0.8, class:^(org.gnome.Nautilus)$"
        "opacity 0.9, class:^(gedit|org.gnome.TextEditor|mousepad)$"
        "opacity 0.9, class:^(org.pulseaudio.pavucontrol)$"
        "opacity 0.9, class:^(kitty)$"
        "opacity 0.85 override 0.7 override 1 override, class:^(discord|vesktop|org.telegram.desktop)$"
        "opacity 0.8 override 0.6 override 1 override, class:^(Spotify)$"
        "opacity 0.9 override 0.7 override 1 override, class:^(zen)$"
        # "opacity 0.8 override 0.6 override 1 override, tag:viewer*"

        # FLOAT
        "float, tag:settings*"
        "float, tag:viewer*"
        "float, tag:multimedia_video*"
        "size 900 506, tag:multimedia_video*"
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "size 50% 60%, class:^(org.pulseaudio.pavucontrol)$"

        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # POP UPS AND DIALOGUES
        "float, title:^(Save As|Save a File|Pick Files)$"
        "size 50% 60%, title:^(Save As|Save a File|Pick Files)$"
        "center, title:^(Save As|Save a File|Pick Files)$"

        "float, initialTitle:(Open Files)"
        "size 70% 60%, initialTitle:(Open Files)"
      ];

      layerrule = [
        "blur, waybar"
        "ignorealpha 0.5, waybar"
        "ignorealpha 0.5, tag:notif*"
        "blur, logout_dialog"
        # "blur, notifications"

        # SWAYNC BLUR & XRAY
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
        "xray 0, swaync-control-center"
        "xray 0, swaync-notification-window"    
      ];
    };
  };
}

#layerrule = blur, rofi
#layerrule = ignorezero, rofi
#layerrule = ignorealpha 0.5, rofi
#layerrule = dimaround, rofi
#layerrule = animation popin 10%, rofi
#layerrule = blur, notifications
#layerrule = ignorezero, notifications


