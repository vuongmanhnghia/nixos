# matugen/auto-wallpaper.nix - Tự động thay đổi wallpaper
{ config, pkgs, lib, ... }:

{
  # Script để chọn wallpaper ngẫu nhiên
  home.file.".local/bin/auto-wallpaper.sh" = {
    source = ../scripts/auto-wallpaper.sh;
    executable = true;
  };

  # Systemd service cho auto wallpaper
  systemd.user.services.auto-wallpaper = {
    Unit = {
      Description = "Auto change wallpaper with Matugen";
      After = [ "graphical-session.target" ];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.local/bin/auto-wallpaper.sh";
      Environment = [ 
        "PATH=${lib.makeBinPath (with pkgs; [ matugen swww waybar hyprland cava libnotify coreutils findutils ])}"
      ];
    };
  };

  # Systemd timer - thay đổi thời gian ở đây
  systemd.user.timers.auto-wallpaper = {
    Unit = {
      Description = "Auto change wallpaper timer";
      Requires = [ "auto-wallpaper.service" ];
    };
    
    Timer = {
      OnCalendar = "*:0/5";      # Mỗi 5 phút
      
      # Chạy ngay khi timer được kích hoạt
      OnStartupSec = "5min";
      
      # Randomize thời gian một chút để tránh tất cả chạy cùng lúc
      RandomizedDelaySec = "2min";
      
      Persistent = true;
    };
    
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # Thêm shell aliases để điều khiển
  home.shellAliases = lib.mkMerge [
    {
      # Auto wallpaper controls
      "auto-wp-start" = "systemctl --user start auto-wallpaper.timer";
      "auto-wp-stop" = "systemctl --user stop auto-wallpaper.timer";
      "auto-wp-status" = "systemctl --user status auto-wallpaper.timer";
      "auto-wp-now" = "systemctl --user start auto-wallpaper.service";
      "auto-wp-enable" = "systemctl --user enable auto-wallpaper.timer";
      "auto-wp-disable" = "systemctl --user disable auto-wallpaper.timer";
    }
  ];
}