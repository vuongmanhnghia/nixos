#!/run/current-system/sw/bin/bash

# Fcitx5 Setup Script for Vietnamese Input Method
# This script configures Fcitx5 with Unikey for Vietnamese typing

echo "Setting up Fcitx5 with Unikey..."

# Create fcitx5 config directory if it doesn't exist
mkdir -p ~/.config/fcitx5

# Backup existing config
if [ -f ~/.config/fcitx5/profile ]; then
    cp ~/.config/fcitx5/profile ~/.config/fcitx5/profile.backup
fi

# Create proper profile with Unikey
cat > ~/.config/fcitx5/profile << 'EOF'
[Groups/0]
# Group Name
Name=Default
# Layout
Default Layout=us
# Default Input Method
DefaultIM=keyboard-us

[Groups/0/Items/0]
# Name
Name=keyboard-us
# Layout
Layout=

[Groups/0/Items/1]
# Name
Name=unikey
# Layout
Layout=

[GroupOrder]
0=Default
EOF

# Create proper config
cat > ~/.config/fcitx5/config << 'EOF'
[Hotkey]
# Enumerate when press trigger key repeatedly
EnumerateWithTriggerKeys=True
# Enumerate Input Method Forward
EnumerateForwardKeys=
# Enumerate Input Method Backward
EnumerateBackwardKeys=
# Skip first input method while enumerating
EnumerateSkipFirst=False
# Time limit in milliseconds for triggering modifier key shortcuts
ModifierOnlyKeyTimeout=250

[Hotkey/TriggerKeys]
0=Control+space
1=Zenkaku_Hankaku
2=Hangul

[Hotkey/AltTriggerKeys]
0=Shift_L

[Hotkey/EnumerateGroupForwardKeys]
0=Super+space

[Hotkey/EnumerateGroupBackwardKeys]
0=Shift+Super+space

[Hotkey/ActivateKeys]
0=Hangul_Hanja

[Hotkey/DeactivateKeys]
0=Hangul_Romaja

[Hotkey/PrevPage]
0=Up

[Hotkey/NextPage]
0=Down

[Hotkey/PrevCandidate]
0=Shift+Tab

[Hotkey/NextCandidate]
0=Tab

[Hotkey/TogglePreedit]
0=Control+Alt+P

[Behavior]
# Active By Default
ActiveByDefault=False
# Reset state on Focus In
resetStateWhenFocusIn=No
# Share Input State
ShareInputState=No
# Show preedit in application
PreeditEnabledByDefault=False
# Show Input Method Information when switch input method
ShowInputMethodInformation=True
# Show Input Method Information when changing focus
showInputMethodInformationWhenFocusIn=True
# Show compact input method information
CompactInputMethodInformation=True
# Show first input method information
ShowFirstInputMethodInformation=True
# Default page size
DefaultPageSize=5
# Override Xkb Option
OverrideXkbOption=False
# Custom Xkb Option
CustomXkbOption=
# Force Enabled Addons
EnabledAddons=
# Force Disabled Addons
DisabledAddons=
# Preload input method to be used by default
PreloadInputMethod=True
# Allow input method in the password field
AllowInputMethodForPassword=False
# Show preedit text when typing password
ShowPreeditForPassword=False
# Interval of saving user data in minutes
AutoSavePeriod=30
EOF

# Create conf directory
mkdir -p ~/.config/fcitx5/conf

# Create classicui config for better Wayland support
cat > ~/.config/fcitx5/conf/classicui.conf << 'EOF'
# Vertical Candidate List
Vertical Candidate List=False
# Use mouse wheel to go to prev or next page
WheelForPaging=True
# Font
Font="Sans 10"
# Menu Font
MenuFont="Sans 10"
# Use Per Screen DPI
PerScreenDPI=True
# Force font DPI on Wayland
ForceWaylandDPI=0
# Enable fractional scale under Wayland
EnableFractionalScale=True
EOF

# Create notifications config
cat > ~/.config/fcitx5/conf/notifications.conf << 'EOF'
# Notifications when switching input method
HiddenNotifications=
EOF

echo "Fcitx5 configuration completed!"
echo "Unikey should now be available in Fcitx5 configuration tool." 