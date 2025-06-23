{ config, pkgs, lib, ... }:

{
  # === TỐI ƯU CẤU HÌNH AUDIO CHO NIXOS 25.05 ===
  # Cấu hình PipeWire tối ưu với hỗ trợ đặc biệt cho Spotify và các ứng dụng media

  # 1. Vô hiệu hóa các hệ thống âm thanh cũ để tránh xung đột
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # 2. Kích hoạt PipeWire với đầy đủ các lớp tương thích
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    # 3. Cấu hình PipeWire nâng cao - KHẮC PHỤC SPOTIFY STUTTERING
    extraConfig.pipewire = {
      "context.properties" = {
        # Hỗ trợ sample rates của Spotify (44.1kHz) và hệ thống (48kHz) 
        "default.clock.rate" = 44100;
        "default.clock.allowed-rates" = [ 44100 48000 ];
        
        # Tăng buffer size để tránh underrun (âm thanh bị giật)
        "default.clock.quantum" = 2048;         # Tăng lên 2048 để ổn định
        "default.clock.min-quantum" = 64;       # Tăng min-quantum 
        "default.clock.max-quantum" = 4096;     # Tăng max-quantum để buffer lớn hơn
      };
    };
    
    # 4. Cấu hình PipeWire-Pulse với buffer lớn hơn cho Spotify
    extraConfig.pipewire-pulse = {
      "pulse.properties" = {
        "pulse.min.req" = "512/44100";          # Buffer lớn hơn
        "pulse.default.req" = "512/44100";      
        "pulse.max.req" = "512/44100";
        "pulse.min.quantum" = "512/44100";
        "pulse.max.quantum" = "512/44100";
        "server.address" = [ "unix:native" ];
      };
      "stream.properties" = {
        "node.latency" = "512/44100";
        "resample.quality" = 4;                 
      };
    };
  };

  # 5. Kích hoạt WirePlumber session manager
  services.pipewire.wireplumber.enable = true;
  
  # 6. Ngăn chặn suspend thiết bị âm thanh
  services.pipewire.wireplumber.extraConfig."99-disable-suspend" = {
    "monitor.alsa.rules" = [
      {
        matches = [ { "node.name" = "~alsa_output.*"; } ];
        actions = {
          update-props = {
            "session.suspend-timeout-seconds" = 0;
          };
        };
      }
      {
        matches = [ { "node.name" = "~alsa_input.*"; } ];
        actions = {
          update-props = {
            "session.suspend-timeout-seconds" = 0;
          };
        };
      }
    ];
  };
  
  # 7. Cấu hình đặc biệt cho Spotify
  services.pipewire.wireplumber.extraConfig."50-spotify-optimization" = {
    "monitor.alsa.properties" = {
      "alsa.reserve" = false;
      "alsa.use-acp" = true;
    };
  };

  # 8. Cài đặt các công cụ âm thanh thiết yếu
  environment.systemPackages = with pkgs; [
    pavucontrol        # GUI để điều khiển âm lượng
    helvum             # Patchbay cho PipeWire
    qpwgraph           # Công cụ kết nối trực quan cho PipeWire
    easyeffects        # Hiệu ứng âm thanh và cân bằng âm
    playerctl          # Điều khiển media player từ command line
    pamixer            # Command line mixer cho PulseAudio/PipeWire
    # pw-top             # Monitoring tool cho PipeWire
  ];

  # 9. Thêm vào các nhóm người dùng cần thiết
  users.users.nagih.extraGroups = [ "audio" "video" ];

  # 10. Hỗ trợ âm thanh Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # 11. XDG Portals cho các ứng dụng sandbox
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-wlr
    ];
  };

  # 12. Cấu hình RealtimeKit
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];
  
  # 13. Biến môi trường để tối ưu âm thanh - ƯU TIÊN CAO HỚN ENVIRONMENT.NIX
  environment.sessionVariables = {
    "PIPEWIRE_LATENCY" = "512/44100";
    "PULSE_LATENCY_MSEC" = lib.mkForce "50";  # Ưu tiên cao hơn cho audio optimization
  };
}
