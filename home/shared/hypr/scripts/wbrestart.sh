#!/run/current-system/sw/bin/bash

pkill -9 swaync
pkill -9 waybar

swaync &
waybar &
