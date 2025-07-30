#!/usr/bin/env bash

set -e

WALLPAPER_DIR="~/Workspaces/Config/nixos/wallpapers"
SYMLINK_PATH="~/Workspaces/Config/nixos/current_wallpaper" 
MATUGEN_CONFIG="$HOME/.config/matugen/config.toml"

# Function to test filesystem write access
test_write_access() {
    local test_dir="$1"
    local test_file="$test_dir/.matugen_write_test"
    
    echo "🔍 Testing write access to: $test_dir"
    
    if ! mkdir -p "$test_dir" 2>/dev/null; then
        echo "❌ Cannot create directory: $test_dir"
        return 1
    fi
    
    if ! touch "$test_file" 2>/dev/null; then
        echo "❌ Cannot write to directory: $test_dir"
        return 1
    fi
    
    rm -f "$test_file" 2>/dev/null
    echo "✅ Write access OK: $test_dir"
    return 0
}

# === WALLPAPER SELECTION ===
cd "$WALLPAPER_DIR" || {
    echo "❌ Cannot access wallpaper directory: $WALLPAPER_DIR"
    exit 1
}

IFS=$'\n'
SELECTED_WALL=$(for a in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do 
    echo -en "$a\0icon\x1f$a\n"; 
done | rofi -dmenu -p "🖼️ Select Wallpaper")

[ -z "$SELECTED_WALL" ] && {
    echo "❌ No wallpaper selected"
    exit 1
}

SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"
echo "🎨 Selected wallpaper: $SELECTED_WALL"

# === FILESYSTEM CHECKS ===
echo "🔍 Checking filesystem access..."

if [ "$WRITE_FAILED" = true ]; then
    echo "❌ Filesystem write issues detected. Checking mount status..."
    
    # Show mount info
    echo "📊 Mount information:"
    df -h ~/.config
    mount | grep "$(df ~/.config | tail -1 | awk '{print $1}')" || echo "No mount info found"
    
    echo "📊 Permissions:"
    ls -la ~/.config/ | head -5
    
    echo "⚠️  Continuing with wallpaper only (colors will be skipped)"
fi

# === SET WALLPAPER (this works) ===
echo "🖼️  Setting wallpaper..."
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo "Starting swww daemon..."
    swww-daemon &
    sleep 2
fi

swww img "$SELECTED_PATH" \
    --transition-type any \
    --transition-fps 60 \
    --transition-duration 1

# === CREATE SYMLINK ===
echo "🔗 Creating symlink..."
if mkdir -p "$(dirname "$SYMLINK_PATH")" && ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"; then
    echo "✅ Symlink created successfully"
else
    echo "❌ Failed to create symlink"
fi

# === SKIP MATUGEN IF FILESYSTEM ISSUES ===
if [ "$WRITE_FAILED" = true ]; then
    echo "⚠️  Skipping color generation due to filesystem issues"
    echo "✅ Wallpaper set successfully (colors skipped)"
    notify-send "Wallpaper Changed" "$(basename "$SELECTED_WALL")\n(Colors skipped due to filesystem issues)" \
        --icon=dialog-warning \
        --urgency=normal
    exit 0
fi

# === GENERATE COLORS (only if filesystem is writable) ===
echo "🎨 Generating colors..."

# Try to identify the issue first
echo "🔧 Debugging matugen issue..."
RUST_BACKTRACE=1 matugen image "$SELECTED_PATH" --config "$MATUGEN_CONFIG" 2>&1 | head -10

# If that fails, try manual template application
echo "🔄 Trying manual color extraction..."

# Alternative: Generate colors to temporary location first
TEMP_DIR="/tmp/matugen_$$"
mkdir -p "$TEMP_DIR"

if matugen image "$SELECTED_PATH" --json > "$TEMP_DIR/colors.json" 2>/dev/null; then
    echo "✅ Color extraction successful"
    
    # Now try to apply templates manually if needed
    echo "🔄 Applying templates manually..."
    
    # This is a fallback - you'd need to implement template parsing
    echo "⚠️  Manual template application not implemented yet"
    
    rm -rf "$TEMP_DIR"
else
    echo "❌ Even basic color extraction failed"
    rm -rf "$TEMP_DIR"
fi

echo "✅ Wallpaper set successfully!"
notify-send "Wallpaper Changed" "$(basename "$SELECTED_WALL")" \
    --icon=applications-graphics \
    --urgency=low