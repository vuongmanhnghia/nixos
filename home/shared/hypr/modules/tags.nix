{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "tag +multimedia_video, class:^([Mm]pv|vlc)$"
        "tag +settings, class:^(nm-applet|nm-connection-editor|blueman-manager|org.gnome.FileRoller)$"
        "tag +settings, class:^(org.gnome.DiskUtility|wihotspot(-gui)?)$"
        "tag +viewer, class:^(org.gnome.SystemMonitor)$"
        "tag +viewer, class:^(org.gnome.Evince)$"
        "tag +viewer, class:^(eog|org.gnome.Loupe)$"
      ];
    };
  };
}



