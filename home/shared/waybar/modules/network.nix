{ config, pkgs, lib, ... }:
{
  config.waybar.modules.network = {
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
      on-click-right = "~/Workspaces/Config/nixos/home/shared/hypr/scripts/waybar-scripts.sh --nmtui";
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
  };
}