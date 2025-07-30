# home/shared/wlogout.nix - Advanced wlogout configuration
{ config, pkgs, lib, ... }:

let
  # Đường dẫn tới script hyprlock
  hyprLockScript = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/hyprlock.sh";
in
{
  # Cài đặt wlogout và dependencies
  home.packages = with pkgs; [
    wlogout
    papirus-icon-theme # Icon theme
  ];

  # Tạo file layout với format đúng cho wlogout
  xdg.configFile."wlogout/layout".text = ''
    {
        "label" : "lock",
        "action" : "${hyprLockScript}",
        "text" : "Lock",
        "keybind" : "l"
    }
    {
        "label" : "reboot", 
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
    }
    {
        "label" : "shutdown",
        "action" : "systemctl poweroff", 
        "text" : "Shutdown",
        "keybind" : "s"
    }
    {
        "label" : "logout",
        "action" : "loginctl kill-session $XDG_SESSION_ID",
        "text" : "Logout", 
        "keybind" : "e"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
    }
    {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h" 
    }
  '';

    # Tạo thư mục icons và copy custom icons (nếu có)
  xdg.configFile."wlogout/icons/.keep".text = ""; # Tạo thư mục
  
  xdg.configFile."wlogout/icons/lock.png".source = ./icons/lock.png;
  xdg.configFile."wlogout/icons/logout.png".source = ./icons/logout.png;
  xdg.configFile."wlogout/icons/sleep.png".source = ./icons/sleep.png;
  xdg.configFile."wlogout/icons/power.png".source = ./icons/power.png;
  xdg.configFile."wlogout/icons/restart.png".source = ./icons/restart.png;
  xdg.configFile."wlogout/icons/hibernate.png".source = ./icons/hibernate.png;
  # CSS styling với sử dụng system icons
  xdg.configFile."wlogout/style.css".text = ''
    * {
        background-image: none;
        font-size: 20px;
        font-family: "JetBrains Mono NFM";
    }
    
    @import "/home/nagih/Workspaces/Config/nixos/colors/waybar.css";
    
    window {
        background-color: rgba(17, 17, 17, 0.45);
    }
    
    button {
        border-radius: 20px;
        margin: 10px;
        color: @inverse_surface;
        border-color: @inverse_surface;
        background-color: rgba(0, 0, 0, 0.5);
        outline-style: none;
        border-style: solid;
        border-width: 0px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        box-shadow: none;
        text-shadow: none;
        animation: gradient_f 20s ease-in infinite;
        opacity: 1;
    }
    
    button:hover,
    button:focus {
        background-color: @on_secondary_fixed_variant;
        background-size: 30%;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(0.55, 0, 0.28, 1.682);
    }
    
    button span {
        font-size: 1.2em;
    }
    
    #lock { background-image: image(url("./icons/lock.png")); }
    #logout { background-image: image(url("./icons/logout.png")); }
    #suspend { background-image: image(url("./icons/sleep.png")); }
    #shutdown { background-image: image(url("./icons/power.png")); }
    #reboot { background-image: image(url("./icons/restart.png")); }
    #hibernate { background-image: image(url("./icons/hibernate.png")); }
  '';

  # Shell aliases
  home.shellAliases = {
    logout-menu = "wlogout";
    wl = "wlogout";
  };

  # Session variables (tùy chọn)
  home.sessionVariables = {
    WLOGOUT_STYLE = "${config.xdg.configHome}/wlogout/style.css";
  };
}