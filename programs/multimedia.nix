{ config, pkgs, ... }:

{
  # === VIETNAMESE INPUT METHOD CONFIGURATION ===
  i18n.inputMethod = {
    enable = true;           # Enable input method support
    type = "fcitx5";         # Use Fcitx5 input method framework (modern and efficient)
    fcitx5.addons = with pkgs; [
      fcitx5-unikey    # Vietnamese input method (Unikey for Vietnamese typing)
      fcitx5-gtk       # GTK integration for better desktop environment support
    ];
  };

  # === FCITX5 CONFIGURATION FOR PER-APPLICATION INPUT METHOD ===
  environment.etc."xdg/fcitx5/config".text = ''
    [Hotkey]
    # Trigger keys for input method switching
    TriggerKeys=
    # Enumerate input methods when switching
    EnumerateWithTriggerKeys=True
    # Skip first input method when enumerating  
    EnumerateSkipFirst=False

    [Hotkey/TriggerKeys]
    0=Control+space
    1=Zenkaku_Hankaku
    2=Hangul

    [Behavior]
    # Active by default when typing
    ActiveByDefault=False
    # Share input state among all applications (false = per-application)
    ShareInputState=False
    # Preload input method
    PreeditEnabledByDefault=True
    # Show input method information when switching
    ShowInputMethodInformation=True
    # Show input method information when focus changes
    showInputMethodInformationWhenFocusIn=False
    # Compact input method information
    CompactInputMethodInformation=True
    # Show first input method mode
    ShowFirstInputMethodInformation=True
    # Default page size for candidate list
    DefaultPageSize=5
    # Override Xkb Options
    OverrideXkbOption=False
    # Custom Xkb Options
    CustomXkbOption=
    # Force enabled addons
    EnabledAddons=
    # Force disabled addons  
    DisabledAddons=
    # Preload input method
    PreloadInputMethod=True
    # Allow input method override system XKB settings
    AllowInputMethodForPassword=False
    # Show preedit in application when possible
    PreeditInApplication=True
  '';

  # === MULTIMEDIA APPLICATIONS ===
  environment.systemPackages = with pkgs; [
    # === MEDIA PLAYERS ===
    vlc           # VLC media player - versatile multimedia player supporting most formats
    
    # === IMAGE EDITING AND GRAPHICS ===
    gimp          # GNU Image Manipulation Program - advanced image editor
    
    # === OFFICE PRODUCTIVITY ===
    libreoffice   # LibreOffice suite - complete office productivity suite (Writer, Calc, Impress)
    
    # === DOCUMENT VIEWERS ===
    evince        # GNOME document viewer for PDF, PostScript, and other formats
    
    # === ARCHIVE MANAGEMENT ===
    file-roller   # GNOME archive manager for creating and extracting compressed files
  ];
} 