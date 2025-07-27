{ config, pkgs, lib, ... }:

{
  # Enable Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
    # Waybar settings - converted from your JSON configs
    settings = {
      # Main configuration (based on your "[TOP] 0-Ja-0 Been modified" config)
      mainBar = {
        layer = "bottom";
        exclusive = true;
        passthrough = false;
        position = "top";
        spacing = 3;
        fixed-center = true;
        ipc = true;
        margin-top = 3;
        margin-left = 8;
        margin-right = 8;

        modules-left = [
          # "idle_inhibitor"
          # "custom/separator#blank"
          "clock"
          # "custom/separator#blank"
          # "tray"
          "custom/separator#blank"
          "hyprland/workspaces#rw"
        ];
        modules-center = [
          "mpris"
        ];
        modules-right = [
          # "custom/separator#dot-line"
          "group/notify"
          "battery"
          "custom/separator#blank"
          "group/audio"
          "custom/separator#blank"
          "custom/power"
        ];

        # Temperature module
        temperature = {
          interval = 10;
          tooltip = true;
          hwmon-path = [
            "/sys/class/hwmon/hwmon1/temp1_input"
            "/sys/class/thermal/thermal_zone0/temp"
          ];
          critical-threshold = 82;
          format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = ["󰈸"];
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --nvtop";
        };

        # Backlight module
        backlight = {
          interval = 2;
          align = 0;
          rotate = 0;
          format-icons = [
            " "
            " "
            " "
            "󰃝 "
            "󰃞 "
            "󰃟 "
            "󰃠 "
          ];
          format = "{icon}";
          tooltip-format = "backlight {percent}%";
          icon-size = 10;
          on-click = "";
          on-click-middle = "";
          on-click-right = "";
          on-update = "";
          on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/brightness.sh --inc";
          on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/brightness.sh --dec";
          smooth-scrolling-threshold = 1;
        };

        # Battery module
        battery = {
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-alt-click = "click";
          format-full = "{icon} Full";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
          ];
          format-time = "{H}h {M}min";
          tooltip = true;
          tooltip-format = "{timeTo} {power}w";
          on-click-middle = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/change-blur.sh";
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/wlogout.sh";
        };

        # Bluetooth module
        bluetooth = {
          format = " ";
          format-disabled = "󰂳";
          format-connected = "󰂱 {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias} 󰂄{device_battery_percentage}%";
          tooltip = true;
          on-click = "blueman-manager";
        };

        # Clock module
        clock = {
          interval = 1;
          format = " {:%I:%M %p}"; # AM PM format
          format-alt = " {:%H:%M   %Y, %d %B, %A}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        # CPU module
        cpu = {
          format = "{usage}% 󰍛";
          interval = 1;
          min-length = 5;
          format-alt-click = "click";
          format-alt = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
          format-icons = [
            "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"
          ];
          on-click-right = "gnome-system-monitor";
        };

        # Disk module
        disk = {
          interval = 30;
          path = "/";
          format = "{percentage_used}% 󰋊";
          tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
        };

        # Hyprland language module
        "hyprland/language" = {
          format = "Lang: {}";
          format-en = "US";
          format-tr = "Korea";
          keyboard-name = "at-translated-set-2-keyboard";
          on-click = "hyprctl switchxkblayout $SET_KB next";
        };

        # Hyprland submap module
        "hyprland/submap" = {
          format = "<span style=\"italic\">  {}</span>";
          tooltip = false;
        };

        # Hyprland window module
        "hyprland/window" = {
          format = "{}";
          max-length = 55;
          separate-outputs = true;
          offscreen-css = true;
          offscreen-css-text = "(inactive)";
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) - fish" = "> [$1]";
            "(.*) - zsh" = "> [$1]";
            "(.*) - $term" = "> [$1]";
          };
        };

        # Idle inhibitor module
        idle_inhibitor = {
          tooltip = true;
          tooltip-format-activated = "Idle_inhibitor active";
          tooltip-format-deactivated = "Idle_inhibitor not active";
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        # Keyboard state module
        keyboard-state = {
          capslock = true;
          format = {
            numlock = "N {icon}";
            capslock = "󰪛 {icon}";
          };
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        # Memory module
        memory = {
          interval = 10;
          format = "{used:0.1f}G 󰾆";
          format-alt = "{percentage}% 󰾆";
          format-alt-click = "click";
          tooltip = true;
          tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --btop";
        };

        # MPRIS module
        mpris = {
          interval = 10;
          format = "{player_icon} <i>{dynamic}</i>";
          format-paused = "{status_icon} <i>{artist} {title}</i>";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          scroll-step = 5.0;
          on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
          on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
          smooth-scrolling-threshold = 1;
          tooltip = true;
          tooltip-format = "{status_icon} {dynamic}\nLeft Click: previous\nMid Click: Pause\nRight Click: Next";
          player-icons = {
            chromium = "";
            default = "";
            firefox = "";
            kdeconnect = "";
            mopidy = "";
            mpv = "󰐹";
            spotify = "";
            vlc = "󰕼";
          };
          status-icons = {
            paused = "󰐎";
            playing = "";
            stopped = "";
          };
          dynamic-order = ["artist" "title"];
          ignored-players = ["firefox" "zen"];
          max-length = 50;
        };

        # Network module
        network = {
          format = "{ifname}";
          format-wifi = "{icon}";
          format-ethernet = "󰌘";
          format-disconnected = "󰌙";
          tooltip-format = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
          format-linked = "󰈁 {ifname} (No IP)";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-ethernet = "{ifname} 󰌘";
          tooltip-format-disconnected = "󰌙 Disconnected";
          max-length = 30;
          format-icons = [
            "󰤯" "󰤟" "󰤢" "󰤥" "󰤨"
          ];
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --nmtui";
        };

        "network#speed" = {
          interval = 1;
          format = "{ifname}";
          format-wifi = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-ethernet = "󰌘  {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-disconnected = "󰌙";
          tooltip-format = "{ipaddr}";
          format-linked = "󰈁 {ifname} (No IP)";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-ethernet = "{ifname} 󰌘";
          tooltip-format-disconnected = "󰌙 Disconnected";
          min-length = 24;
          max-length = 24;
          format-icons = [
            "󰤯" "󰤟" "󰤢" "󰤥" "󰤨"
          ];
        };

        # Power profiles daemon module
        power-profiles-daemon = {
          format = "{icon} ";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        # Pulseaudio module
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} 󰂰 {volume}%";
          format-muted = "󰖁";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              "" "" "󰕾" ""
            ];
            ignored-sinks = [
              "Easy Effects Sink"
            ];
          };
          scroll-step = 1;
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle";
          on-click-right = "pavucontrol -t 3";
          on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
          on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
          tooltip-format = "{icon} {desc} | {volume}%";
          smooth-scrolling-threshold = 1;
        };

        # Pulseaudio microphone module
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle-mic";
          on-click-right = "pavucontrol -t 4";
          on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --mic-inc";
          on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --mic-dec";
          tooltip-format = "{source_desc} | {source_volume}%";
          scroll-step = 5;
        };

        # Tray module
        tray = {
          icon-size = 20;
          spacing = 4;
        };

        # Wireplumber module
        wireplumber = {
          format = "{icon} {volume} %";
          format-muted = " Mute";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --toggle";
          on-click-right = "pavucontrol -t 3";
          on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
          on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
          format-icons = [
            "" "" "󰕾" ""
          ];
        };

        "wlr/taskbar" = {
          format = "{icon} {name}";
          icon-size = 16;
          all-outputs = false;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [
            "wofi" "rofi" "kitty" "kitty-dropterm"
          ];
        };

        # === WORKSPACES ===
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            active = "";
            default = "";
          };
        };

        "hyprland/workspaces#roman" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            "1" = "I";
            "2" = "II";
            "3" = "III";
            "4" = "IV";
            "5" = "V";
            "6" = "VI";
            "7" = "VII";
            "8" = "VIII";
            "9" = "IX";
            "10" = "X";
          };
        };

        "hyprland/workspaces#pacman" = {
          active-only = false;
          all-outputs = true;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          show-special = false;
          persistent-workspaces = {
            "*" = 5;
          };
          format = "{icon}";
          format-icons = {
            active = "<span font='12'>󰮯</span>";
            empty = "<span font='8'></span>";
            default = "󰊠";
          };
        };

        # Hyprland workspaces - Kanji style
        "hyprland/workspaces#kanji" = {
          disable-scroll = true;
          show-special = false;
          all-outputs = true;
          format = "{icon}";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
        };

        "hyprland/workspaces#cam" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            "1" = "Uno";
            "2" = "Due";
            "3" = "Tre";
            "4" = "Quattro";
            "5" = "Cinque";
            "6" = "Sei";
            "7" = "Sette";
            "8" = "Otto";
            "9" = "Nove";
            "10" = "Dieci";
          };
        };

        "hyprland/workspaces#numbers" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };

        "hyprland/workspaces#alpha" = {
          active-only = false;
          all-outputs = true;
          format = "{icon}";
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format-icons = {
            "1" = "A";
            "2" = "B";
            "3" = "C";
            "4" = "D";
            "5" = "E";
            "6" = "F";
            "7" = "G";
            "8" = "H";
            "9" = "I";
            "10" = "J";
          };
        };

        "hyprland/workspaces#rw" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          sort-by-number = true;
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          persistent-workspaces = {
            "*" = 5;
          };
          format = "{icon}{windows}";
          format-window-separator = "";
          window-rewrite-default = " ";
          window-rewrite = {
            "title<.*amazon.*>" = " ";
            "class<firefox|org.mozilla.firefox|librewolf|floorp|mercury-browser|[Cc]achy-browser>" = " ";
            "class<zen>" = " 󰰷";
            "class<waterfox|waterfox-bin>" = " ";
            "class<microsoft-edge>" = " ";
            "class<Chromium|Thorium|[Cc]hrome>" = "";
            "class<brave-browser>" = " 🦁";
            "class<tor browser>" = " ";
            "class<firefox-developer-edition>" = " 🦊";
            "class<kitty|konsole>" = " ";
            "class<kitty-dropterm>" = " ";
            "class<com.mitchellh.ghostty>" = " ";
            "class<org.wezfurlong.wezterm>" = " ";
            "class<[Tt]hunderbird|[Tt]hunderbird-esr>" = " ";
            "class<eu.betterbird.Betterbird>" = " ";
            "title<.*gmail.*>" = " 󰊫";
            "class<[Tt]elegram-desktop|org.telegram.desktop|io.github.tdesktop_x64.TDesktop>" = " ";
            "class<discord|[Ww]ebcord|Vesktop>" = " ";
            "title<.*whatsapp.*>" = " ";
            "title<.*zapzap.*>" = " ";
            "title<.*messenger.*>" = " ";
            "title<.*facebook.*>" = " ";
            "title<.*reddit.*>" = " ";
            "title<.*ChatGPT.*>" = " 󰚩";
            "title<.*deepseek.*>" = " 󰚩";
            "title<.*qwen.*>" = " 󰚩";
            "class<subl>" = " 󰅳";
            "class<slack>" = " ";
            "class<mpv>" = " ";
            "class<celluloid|Zoom>" = " ";
            "class<Cider>" = " 󰎆";
            "title<.*Picture-in-Picture.*>" = " ";
            "title<.*youtube.*>" = " ";
            "class<vlc>" = " 󰕼";
            "title<.*cmus.*>" = " ";
            "class<[Ss]potify>" = " ";
            "class<virt-manager>" = " ";
            "class<.virt-manager-wrapped>" = " ";
            "class<virtualbox manager>" = " 💽";
            "title<virtualbox>" = " 💽";
            "class<remmina>" = " 🖥️";
            "class<VSCode|code-url-handler|code-oss|codium|codium-url-handler|VSCodium>" = " 󰨞";
            "class<dev.zed.Zed>" = " 󰵁";
            "class<codeblocks>" = " 󰅩";
            "title<.*github.*>" = " ";
            "class<mousepad>" = " ";
            "class<libreoffice-writer>" = " ";
            "class<libreoffice-startcenter>" = " 󰏆";
            "class<libreoffice-calc>" = " ";
            "title<.*nvim ~.*>" = " ";
            "title<.*vim.*>" = " ";
            "title<.*nvim.*>" = " ";
            "title<.*figma.*>" = " ";
            "title<.*jira.*>" = " ";
            "class<jetbrains-idea>" = " ";
            "class<obs|com.obsproject.Studio>" = " ";
            "class<polkit-gnome-authentication-agent-1>" = " 󰒃";
            "class<nwg-look>" = " ";
            "class<[Pp]avucontrol|org.pulseaudio.pavucontrol>" = " 󱡫";
            "class<steam>" = " ";
            "class<thunar|nemo>" = " 󰝰";
            "class<Gparted>" = " ";
            "class<gimp>" = " ";
            "class<emulator>" = " 📱";
            "class<android-studio>" = " ";
            "class<org.pipewire.Helvum>" = " 󰓃";
            "class<localsend>" = " ";
            "class<PrusaSlicer|UltiMaker-Cura|OrcaSlicer>" = " 󰹛";
          };
        };

        # Custom modules
        "custom/weather" = {
          format = "{}";
          format-alt = "{alt}: {}";
          format-alt-click = "click";
          interval = 3600;
          return-type = "json";
          exec = "$HOME/.config/hypr/UserScripts/Weather.py";
          tooltip = true;
        };

        "custom/file_manager" = {
          format = " ";
          on-click = "xdg-open . &";
          tooltip = true;
          tooltip-format = "File Manager";
        };

        "custom/tty" = {
          format = " ";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/WaybarScripts.sh --term";
          tooltip = true;
          tooltip-format = "Launch Terminal";
        };

        "custom/browser" = {
          format = " ";
          on-click = "xdg-open https://";
          tooltip = true;
          tooltip-format = "Launch Browser";
        };

        "custom/settings" = {
          format = " ";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/Kool_Quick_Settings.sh";
          tooltip = true;
          tooltip-format = "Launch KooL Hyprland Settings Menu";
        };

        "custom/cycle_wall" = {
          format = " ";
          on-click = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
          on-click-right = "$HOME/.config/hypr/UserScripts/WallpaperRandom.sh";
          on-click-middle = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-styles.sh";
          tooltip = true;
          tooltip-format = "Left Click: Wallpaper Menu\nMiddle Click: Random wallpaper\nRight Click: Waybar Styles Menu";
        };

        "custom/hint" = {
          format = "󰺁 HINT!";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/key-hints.sh";
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/key-binds.sh";
          tooltip = true;
          tooltip-format = "Left Click: Quick Tips\nRight Click: Keybinds";
        };

        "custom/dot_update" = {
          format = " 󰁈 ";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/KooLsDotsUpdate.sh";
          tooltip = true;
          tooltip-format = "Check KooL Dots update\nIf available";
        };

        # hypridle inhibitor
        "custom/hypridle" = {
          format = "󱫗 ";
          return-type = "json";
          escape = true;
          exec-on-event = true;
          interval = 60;
          exec = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/hypridle.sh status";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/hypridle.sh toggle";
          on-click-right = "hyprlock";
        };

        "custom/keyboard" = {
          exec = "cat $HOME/.cache/kb_layout";
          interval = 1;
          format = " {}";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/switch-keyboard-layout.sh";
        };

        "custom/light_dark" = {
          format = "󰔎 ";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/dark-light.sh";
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-styles.sh";
          on-click-middle = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
          tooltip = true;
          tooltip-format = "Left Click: Switch Dark-Light Themes\nMiddle Click: Wallpaper Menu\nRight Click: Waybar Styles Menu";
        };

        "custom/lock" = {
          format = "󰌾";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/LockScreen.sh";
          tooltip = true;
          tooltip-format = "󰷛 Screen Lock";
        };

        "custom/menu" = {
          format = "  ";
          on-click = "pkill rofi || rofi -show drun -modi run,drun,filebrowser,window";
          on-click-middle = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-layout.sh";
          tooltip = true;
          tooltip-format = "Left Click: Rofi Menu\nMiddle Click: Wallpaper Menu\nRight Click: Waybar Layout Menu";
        };

        # Custom cava visualizer
        "custom/cava_mviz" = {
          exec = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybarcava.sh";
          format = "{}";
        };

        "custom/playerctl" = {
          format = "<span>{}</span>";
          return-type = "json";
          max-length = 25;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}}  {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          scroll-step = 5.0;
          on-scroll-up = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --inc";
          on-scroll-down = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/volume.sh --dec";
          smooth-scrolling-threshold = 1;
        };

        "custom/power" = {
          format = "⏻";
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/wlogout.sh";
          on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/change-blur.sh";
          tooltip = true;
          tooltip-format = "Logout Menu";
        };

        "custom/reboot" = {
          format = "󰜉";
          on-click = "systemctl reboot";
          tooltip = true;
          tooltip-format = "Left Click: Reboot";
        };

        "custom/quit" = {
          format = "󰗼";
          on-click = "hyprctl dispatch exit";
          tooltip = true;
          tooltip-format = "Left Click: Exit Hyprland";
        };

        "custom/swaync" = {
          tooltip = true;
          tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
          format = " {} {icon} ";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/updater" = {
          format = " {}";
          exec = "checkupdates | wc -l";
          exec-if = "[[ $(checkupdates | wc -l) ]]";
          interval = 43200; # 12 hours interval
          on-click = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/Distro_update.sh";
          tooltip = true;
          tooltip-format = "Left Click: Update System\nArch (w/ notification)\nFedora, OpenSuse, Debian/Ubuntu click to update";
        };

        # Separators
        "custom/separator#dot" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#dot-line" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#line" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#blank" = {
          format = "";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#blank_2" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };

        "custom/separator#blank_3" = {
          format = "   ";
          interval = "once";
          tooltip = false;
        };

        "custom/arrow1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow8" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow9" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow10" = {
          format = "";
          tooltip = false;
        };

        # Groups
        "group/app_drawer" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "custom/menu";
            transition-left-to-right = true;
          };
          modules = [
            "custom/menu"
            "custom/light_dark"
            "custom/file_manager"
            "custom/tty"
            "custom/browser"
            "custom/settings"
          ];
        };

        "group/motherboard" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "power-profiles-daemon"
            "memory"
            "temperature"
            "disk"
          ];
        };

        "group/mobo_drawer" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "cpu";
            transition-left-to-right = true;
          };
          modules = [
            "temperature"
            "cpu"
            "power-profiles-daemon"
            "memory"
            "disk"
          ];
        };

        "group/laptop" = {
          orientation = "inherit";
          modules = [
            "backlight"
            "battery"
          ];
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "pulseaudio";
            transition-left-to-right = true;
          };
          modules = [
            "pulseaudio"
            "pulseaudio#microphone"
          ];
        };

        "group/connections" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "bluetooth";
            transition-left-to-right = true;
          };
          modules = [
            "network"
            "bluetooth"
          ];
        };

        "group/status" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "custom/power";
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/lock"
            "keyboard-state"
            "custom/keyboard"
          ];
        };

        "group/notify" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "custom/swaync";
            transition-left-to-right = false;
          };
          modules = [
            "custom/swaync"
          ];
        };

        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "drawer-child";
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };
      };
    };
    
    # CSS Styling - converted from your CSS files
    style = ''
      @import "/home/nagih/Workspaces/Config/nixos/colors/waybar.css";

      * {
        font-family: "JetBrainsMono Nerd Font Propo";
        font-weight: bold;
        min-height: 0;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      }

      window#waybar,
      window#waybar.empty,
      window#waybar.empty #window {
        background-color: transparent;
        padding: 0px;
        border: 0px;
      }

      tooltip {
        color: @inverse_surface;
        background: rgba(0, 0, 0, 0.8);
        border-radius: 20px;
      }

      tooltip label {
        color: @inverse_surface;
      }

      /*-----module groups----*/
      .modules-right {
        color: @secondary;
        padding-top: 2px;
        padding-bottom: 2px;
        padding-right: 4px;
        padding-left: 4px;
      }

      .modules-center {
        color: @secondary;
        padding-top: 2px;
        padding-bottom: 2px;
        padding-right: 4px;
        padding-left: 4px;
      }

      .modules-left {
        color: @secondary;
        padding-top: 2px;
        padding-bottom: 2px;
        padding-right: 4px;
        padding-left: 4px;
      }

      /*-----modules indv----*/
      #taskbar button,
      #workspaces button {
        color: @outline;
        box-shadow: none;
        text-shadow: none;
        padding: 0px;
        padding-bottom: 0px;
        padding-top: 1px;
        border-radius: 9px;
        padding-left: 10px;
        padding-right: 10px;
        margin-left: 4px;
        margin-right: 4px;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button:hover,
      #workspaces button:hover {
        color: @primary;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button.active,
      #workspaces button.active {
        color: @background;
        background-color: alpha(@primary_fixed, 0.75);
        padding-left: 10px;
        padding-right: 10px;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.urgent {
        color: @primary;
        border-radius: 10px;
      }

      #workspaces button.persistent {
        border-radius: 10px;
      }

      #custom-swaync {
        background-color: alpha(@surface_container, 0.75);
        border-radius: 20px;
        padding: 8px;
        margin: 0 0 0 5px;
      }

      #backlight,
      #backlight-slider,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #idle_inhibitor,
      #keyboard-state,
      #memory,
      #mode,
      #mpris,
      #network,
      #power-profiles-daemon,
      #pulseaudio,
      #pulseaudio-slider,
      #taskbar,
      #temperature,
      #tray,
      #window,
      #wireplumber,
      #workspaces,
      #custom-backlight,
      #custom-browser,
      #custom-cava_mviz,
      #custom-cycle_wall,
      #custom-dot_update,
      #custom-file_manager,
      #custom-keybinds,
      #custom-keyboard,
      #custom-light_dark,
      #custom-lock,
      #custom-hint,
      #custom-hypridle,
      #custom-menu,
      #custom-playerctl,
      #custom-power_vertical,
      #custom-power,
      #custom-quit,
      #custom-reboot,
      #custom-settings,
      #custom-spotify,
      #custom-tty,
      #custom-updater,
      #custom-weather,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.default, 
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.severe,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.sunnyDay {
        background-color: alpha(@surface_container, 0.75);
        /* border: 1px solid @surface_container; */
        border-radius: 20px;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-right: 15px;
        padding-left: 15px;
        margin: 0 0 0 5px;
      }i

      /*-----Indicators----*/
      #custom-hypridle.notactive,
      #idle_inhibitor.activated {
        color: #39FF14;
      }

      #pulseaudio.muted {
        color: #cc3436;
      }

      #temperature.critical {
        color: red;
      }

      @keyframes blink {
        to {
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        color: #f53c3c;
      }

      #backlight-slider slider,
      #pulseaudio-slider slider {
        min-width: 0px;
        min-height: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      #backlight-slider trough,
      #pulseaudio-slider trough {
        min-width: 80px;
        min-height: 5px;
        border-radius: 5px;
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        min-height: 10px;
        border-radius: 5px;
      }
    '';
  };
}