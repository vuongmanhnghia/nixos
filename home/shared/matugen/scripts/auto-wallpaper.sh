#!/run/current-system/sw/bin/bash

WALLPAPER_DIR="/home/nagih/Workspaces/Config/nixos/wallpapers"
SYMLINK_PATH="/home/nagih/Workspaces/Config/nixos/current_wallpaper"

# Kiểm tra thư mục wallpaper tồn tại
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Lấy danh sách các file wallpaper
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) 2>/dev/null))

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    exit 1
fi

# Lấy wallpaper hiện tại (nếu có)
CURRENT=""
if [ -f "$SYMLINK_PATH" ]; then
    CURRENT=$(readlink -f "$SYMLINK_PATH" 2>/dev/null || cat "$SYMLINK_PATH" 2>/dev/null)
fi

# Chọn wallpaper ngẫu nhiên (khác với hiện tại nếu có nhiều hơn 1 wallpaper)
SELECTED_PATH=""
if [ ${#WALLPAPERS[@]} -gt 1 ]; then
    while [ -z "$SELECTED_PATH" ] || [ "$SELECTED_PATH" = "$CURRENT" ]; do
        SELECTED_PATH="${WALLPAPERS[$RANDOM % ${#WALLPAPERS[@]}]}"
    done
else
    SELECTED_PATH="${WALLPAPERS[0]}"
fi

# Áp dụng wallpaper mới với matugen
matugen image "$SELECTED_PATH"

# Cập nhật symlink
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH" 