#!/run/current-system/sw/bin/bash
# Main matugen application script

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/reload-apps.sh"

WALLPAPER="$1"
if [ -z "$WALLPAPER" ]; then
    echo "Usage: $0 <wallpaper_path>"
    exit 1
fi

if [ ! -f "$WALLPAPER" ]; then
    echo "Error: Wallpaper file '$WALLPAPER' not found"
    exit 1
fi

echo "🎨 Applying colors from: $WALLPAPER"

# Save current wallpaper path
mkdir -p ~/.config/hypr
echo "$WALLPAPER" > ~/Workspaces/Config/nixos/current_wallpaper

# Set wallpaper
"$SCRIPT_DIR/set-wallpaper.sh" "$WALLPAPER"

# Generate and apply color templates
echo "🔄 Generating color templates..."
matugen image "$WALLPAPER" --config ~/.config/matugen/config.toml

# Reload applications
echo "♻️  Reloading applications..."
reload_waybar
reload_kitty
reload_hyprland

echo "✅ Matugen applied successfully!"
notify-send "Matugen" "Colors applied successfully!" \
    --icon=applications-graphics \
    --urgency=low