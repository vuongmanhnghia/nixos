#!/run/current-system/sw/bin/bash
# Wallpaper setter script

WALLPAPER="$1"

if [ -z "$WALLPAPER" ]; then
    echo "Usage: $0 <wallpaper_path>"
    exit 1
fi

echo "🖼️  Setting wallpaper: $(basename "$WALLPAPER")"

# Check if swww daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "Starting swww daemon..."
    swww-daemon &
    sleep 1
fi

# Set wallpaper with swww
swww img "$WALLPAPER" \
    --transition-type any \
    --transition-fps 60 \
    --transition-duration 1

echo "✅ Wallpaper set successfully"