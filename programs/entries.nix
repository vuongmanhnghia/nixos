{ config, pkgs, ... }:
{
  # Enable XDG support
  xdg.enable = true;
  
  # Đảm bảo desktop entries được enable
  xdg.desktopEntries = {
    cursor-wayland = {
      name = "Cursor (Wayland)";
      comment = "Cursor Code Editor for Wayland";
      exec = "cursor --disable-gpu";
      icon = "cursor";
      terminal = false;
      categories = [ "Development" "IDE" ];
      settings = {
        StartupWMClass = "cursor";
      };
    };
  };
}