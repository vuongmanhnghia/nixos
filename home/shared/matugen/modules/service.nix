# matugen/service.nix - Systemd service
{ config, pkgs, lib, ... }:

{
  # Optional: Add systemd service to auto-generate colors on wallpaper change
  systemd.user.services.matugen-auto = {
    Unit = {
      Description = "Auto-generate colors with Matugen";
      After = [ "graphical-session.target" ];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.matugen}/bin/matugen image %h/home/nagih/Workspaces/Config/nixos/current_wallpaper";
      Environment = [ "PATH=${pkgs.swww}/bin:${pkgs.waybar}/bin:${pkgs.hyprland}/bin:${pkgs.cava}/bin" ];
    };
    
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}