# matugen/auto-wallpaper.nix - Tự động thay đổi wallpaper
{ config, pkgs, lib, ... }:

{
  # Script để chọn wallpaper ngẫu nhiên
  home.file.".local/bin/auto-wallpaper.sh" = {
    text = ''
      #!/run/current-system/sw/bin/bash
      
      WALLPAPER_DIR="$HOME/Workspaces/Config/nixos/wallpapers"
      CURRENT_WALLPAPER="$HOME/Workspaces/Config/nixos/current_wallpaper"
      
      # Kiểm tra thư mục wallpaper tồn tại
      if [ ! -d "$WALLPAPER_DIR" ]; then
          echo "Wallpaper directory not found: $WALLPAPER_DIR"
          exit 1
      fi
      
      # Lấy danh sách các file wallpaper
      WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) 2>/dev/null))
      
      if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
          echo "No wallpapers found in $WALLPAPER_DIR"
          exit 1
      fi
      
      # Lấy wallpaper hiện tại (nếu có)
      CURRENT=""
      if [ -f "$CURRENT_WALLPAPER" ]; then
          CURRENT=$(readlink -f "$CURRENT_WALLPAPER" 2>/dev/null || cat "$CURRENT_WALLPAPER" 2>/dev/null)
      fi
      
      # Chọn wallpaper ngẫu nhiên (khác với hiện tại nếu có nhiều hơn 1 wallpaper)
      SELECTED_WALLPAPER=""
      if [ ''${#WALLPAPERS[@]} -gt 1 ]; then
          while [ -z "$SELECTED_WALLPAPER" ] || [ "$SELECTED_WALLPAPER" = "$CURRENT" ]; do
              SELECTED_WALLPAPER="''${WALLPAPERS[$RANDOM % ''${#WALLPAPERS[@]}]}"
          done
      else
          SELECTED_WALLPAPER="''${WALLPAPERS[0]}"
      fi
      
      echo "🎨 Auto-changing wallpaper to: $(basename "$SELECTED_WALLPAPER")"
      
      # Áp dụng wallpaper mới với matugen
      ${pkgs.matugen}/bin/matugen image "$SELECTED_WALLPAPER"
      
      # Cập nhật symlink
      ln -sf "$SELECTED_WALLPAPER" "$CURRENT_WALLPAPER"
      
      # Gửi thông báo
      ${pkgs.libnotify}/bin/notify-send "Auto Wallpaper" "Changed to $(basename "$SELECTED_WALLPAPER")" \
          --icon=applications-graphics \
          --urgency=low
    '';
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