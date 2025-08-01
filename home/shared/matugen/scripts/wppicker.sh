#!/usr/bin/env bash

# === CONFIG ===
WALLPAPER_DIR="/home/nagih/Workspaces/Config/nixos/wallpapers"
SYMLINK_PATH="/home/nagih/Workspaces/Config/nixos/current_wallpaper"

echo "🔍 Testing write access to: $WALLPAPER_DIR"

cd "$WALLPAPER_DIR" || exit 1

# === handle spaces name
IFS=$'\n'

echo "🔍 Testing write access to: $SYMLINK_PATH"

# === ICON-PREVIEW SELECTION WITH ROFI, SORTED BY NEWEST ===
SELECTED_WALL=$(for a in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -p "")
[ -z "$SELECTED_WALL" ] && exit 1
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

echo "🔍 Setting wallpaper: $SELECTED_PATH"

# === SET WALLPAPER ===
matugen image "$SELECTED_PATH"

echo "🔍 Creating symlink: $SYMLINK_PATH"

# === CREATE SYMLINK ===
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"

