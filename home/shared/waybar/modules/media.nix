{ config, pkgs, lib, ... }:

{
  config.waybar.modules.media = {
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
  };
}