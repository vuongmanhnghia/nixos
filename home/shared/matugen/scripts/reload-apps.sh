#!/run/current-system/sw/bin/bash
# Application reload functions

reload_waybar() {
    if pgrep -x waybar > /dev/null; then
        echo "  📊 Reloading waybar..."
        pkill -SIGUSR2 waybar
    else
        echo "  📊 Waybar not running, skipping reload"
    fi
}

reload_kitty() {
    if pgrep -x kitty > /dev/null; then
        echo "  🐱 Reloading kitty..."
        kill -SIGUSR1 $(pidof kitty) 2>/dev/null || true
    else
        echo "  🐱 Kitty not running, skipping reload"
    fi
}

reload_hyprland() {
    if pgrep -x Hyprland > /dev/null; then
        echo "  🪟 Reloading hyprland..."
        hyprctl reload 2>/dev/null || true
    else
        echo "  🪟 Hyprland not running, skipping reload"
    fi
}

reload_spicetify() {
    if pgrep -x spotify > /dev/null; then
        echo "  🎵 Reloading spotify..."
        # spicetify apply 2>/dev/null || true
        pkill -SIGUSR1 spotify 2>/dev/null || true
    else
        echo "  🎵 Spotify not running, skipping reload"
    fi
}