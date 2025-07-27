#!/run/current-system/sw/bin/bash

killall -9 swaync
killall -9 waybar

swaync &
waybar &
