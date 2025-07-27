#!/run/current-system/sw/bin/bash

# Fcitx5 Unikey Fix Script
# This script checks and fixes Fcitx5 Unikey issues

echo "=== Fcitx5 Unikey Diagnostic and Fix Script ==="
echo ""

# Check if fcitx5 is running
echo "1. Checking Fcitx5 status..."
if pgrep -x "fcitx5" > /dev/null; then
    echo "   ✓ Fcitx5 is running"
else
    echo "   ✗ Fcitx5 is not running"
    echo "   Starting Fcitx5..."
    fcitx5 -d --replace
    sleep 2
fi

# Check current input method
echo ""
echo "2. Checking current input method..."
CURRENT_IM=$(fcitx5-remote -n 2>/dev/null)
if [ "$CURRENT_IM" = "unikey" ]; then
    echo "   ✓ Current IM: $CURRENT_IM"
else
    echo "   ⚠ Current IM: $CURRENT_IM (should be unikey)"
fi

# Check available input methods
echo ""
echo "3. Checking available input methods..."
if fcitx5-remote -m unikey > /dev/null 2>&1; then
    echo "   ✓ Unikey is available"
else
    echo "   ✗ Unikey is not available"
fi

# Check profile configuration
echo ""
echo "4. Checking profile configuration..."
if [ -f ~/.config/fcitx5/profile ]; then
    if grep -q "unikey" ~/.config/fcitx5/profile; then
        echo "   ✓ Unikey found in profile"
    else
        echo "   ✗ Unikey not found in profile"
        echo "   Running setup script..."
        ~/.config/hypr/scripts/fcitx5-setup.sh
    fi
else
    echo "   ✗ Profile file not found"
    echo "   Running setup script..."
    ~/.config/hypr/scripts/fcitx5-setup.sh
fi

# Check environment variables
echo ""
echo "5. Checking environment variables..."
ENV_VARS=("GTK_IM_MODULE" "QT_IM_MODULE" "XMODIFIERS" "SDL_IM_MODULE" "FCITX_ENABLE_WAYLAND")
for var in "${ENV_VARS[@]}"; do
    value=$(printenv "$var")
    if [ -n "$value" ]; then
        echo "   ✓ $var=$value"
    else
        echo "   ⚠ $var not set"
    fi
done

# Check if fcitx5-unikey package is installed
echo ""
echo "6. Checking fcitx5-unikey package..."
if command -v fcitx5-unikey > /dev/null 2>&1; then
    echo "   ✓ fcitx5-unikey is installed"
else
    echo "   ✗ fcitx5-unikey is not installed"
    echo "   Please ensure fcitx5-unikey is in your NixOS configuration"
fi

# Restart fcitx5 to apply changes
echo ""
echo "7. Restarting Fcitx5..."
fcitx5-remote -r
sleep 2

# Final check
echo ""
echo "8. Final check..."
NEW_IM=$(fcitx5-remote -n 2>/dev/null)
echo "   Current input method: $NEW_IM"

echo ""
echo "=== Diagnostic Complete ==="
echo ""
echo "If Unikey is still not available:"
echo "1. Open Fcitx5 Configuration Tool: fcitx5-config-qt"
echo "2. Go to 'Input Method' tab"
echo "3. Click '+' to add new input method"
echo "4. Look for 'Unikey' in the list"
echo "5. If not found, check if fcitx5-unikey package is properly installed"
echo ""
echo "To switch to Unikey manually:"
echo "fcitx5-remote -s unikey" 