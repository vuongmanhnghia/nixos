# waybar/modules/hyprland.nix - Hyprland-specific modules
{ config, pkgs, lib, ... }:

{
  config.waybar.modules.hyprland = {
    # === HYPRLAND LANGUAGE MODULE ===
    "hyprland/language" = {
      format = "Lang: {}";
      format-en = "US";
      format-tr = "Korea";
      keyboard-name = "at-translated-set-2-keyboard";
      on-click = "hyprctl switchxkblayout $SET_KB next";
    };

    # === HYPRLAND SUBMAP MODULE ===
    "hyprland/submap" = {
      format = "<span style=\"italic\">  {}</span>";
      tooltip = false;
    };

    # === HYPRLAND WINDOW MODULE ===
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

    # === DEFAULT WORKSPACES ===
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

    # === ROMAN NUMERAL WORKSPACES ===
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

    # === PACMAN WORKSPACES ===
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

    # === KANJI WORKSPACES ===
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

    # === ITALIAN WORKSPACES ===
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

    # === NUMBER WORKSPACES ===
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

    # === ALPHABET WORKSPACES ===
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

    # === RICH WORKSPACES (with window icons) ===
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
  };
}