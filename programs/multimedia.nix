{ config, pkgs, ... }:

let
  # === NOTION CONFIGURATION ===
  notion-app = pkgs.appimageTools.wrapType2 {
    pname = "notion-app";
    name = "notion-app";
    version = "2.3.2-1";
    src = pkgs.fetchurl {
      url = "https://github.com/kidonng/notion-appimage/releases/download/2.3.2-1/Notion-2.3.2-1-x86-64.AppImage";
      sha256 = "06ki585zpdzsljknal6by6dac24r6r82w844h70ngzqf6y7lwxgy";
    };
    # Additional AppImage options for better integration
    extraPkgs = pkgs: with pkgs; [ ];
  };
in
{
  # === VIETNAMESE INPUT METHOD CONFIGURATION ===
  i18n.inputMethod = {
    enable = true;           # Enable input method support
    type = "fcitx5";         # Use Fcitx5 input method framework (modern and efficient)
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-unikey          # Vietnamese input method (Unikey for Vietnamese typing)
        fcitx5-gtk             # GTK integration for better desktop environment support
        libsForQt5.fcitx5-qt   # Qt5 integration for Qt5 applications
        qt6Packages.fcitx5-qt  # Qt6 integration for Qt6 applications  
        fcitx5-configtool      # Configuration tool
        fcitx5-with-addons     # Additional addons for better compatibility
      ];
      waylandFrontend = true;  # Enable Wayland frontend
    };
  };

  # === ENVIRONMENT VARIABLES FOR OPTIMAL WAYLAND SUPPORT ===
  environment.sessionVariables = {
    # Input Method Module settings for different toolkits
    GTK_IM_MODULE = "fcitx";     # Force GTK to use fcitx even on Wayland
    QT_IM_MODULE = "fcitx";      # Qt applications
    XMODIFIERS = "@im=fcitx";    # For XWayland applications
    SDL_IM_MODULE = "fcitx";     # SDL applications
    GLFW_IM_MODULE = "ibus";     # GLFW applications fallback
    
    # Fcitx5 specific environment variables
    FCITX_ENABLE_WAYLAND = "1";
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
    # CRITICAL: Share input state among all applications (false = per-application)
    ShareInputState=False
    # Per-application input method state
    PreeditEnabledByDefault=False
    # Show input method information when switching
    ShowInputMethodInformation=True
    # Show input method information when focus changes
    showInputMethodInformationWhenFocusIn=True
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
    # Preload input method for faster switching
    PreloadInputMethod=True
    # Allow input method override system XKB settings
    AllowInputMethodForPassword=False
    # Show preedit in application when possible
    PreeditInApplication=True
    # Remember input method state per application
    DefaultInputMethodState=Inactive
  '';

  # === FCITX5 PROFILE CONFIGURATION FOR INPUT METHOD SWITCHING ===
  environment.etc."xdg/fcitx5/profile".text = ''
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
  '';

  # === ADDITIONAL FCITX5 CONFIGURATIONS FOR WAYLAND ===
  # User-level configuration to override system defaults
  environment.etc."xdg/fcitx5/conf/classicui.conf".text = ''
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
  '';

  # === FCITX5 ADDON CONFIGURATION ===
  environment.etc."xdg/fcitx5/conf/notifications.conf".text = ''
    # Notifications when switching input method
    HiddenNotifications=
  '';

  # === SYSTEMD USER SERVICE FOR FCITX5 AUTOSTART ===
  systemd.user.services.fcitx5-daemon = {
    description = "Fcitx5 input method editor";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    
    environment = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      FCITX_ENABLE_WAYLAND = "1";
    };
    
    serviceConfig = {
      Type = "dbus";
      BusName = "org.fcitx.Fcitx5";
      ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
      ExecReload = "${pkgs.coreutils}/bin/kill -USR1 $MAINPID";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };

  # === FCITX5 SERVICE CONFIGURATION FOR GNOME INTEGRATION ===
  services.dbus.packages = with pkgs; [ fcitx5 ];
  
  # === SYSTEM PACKAGES: INPUT METHOD + MULTIMEDIA APPLICATIONS ===
  environment.systemPackages = with pkgs; [
    # === MEDIA PLAYERS ===
    vlc                       # VLC media player - versatile multimedia player supporting most formats
    
    # === IMAGE EDITING AND GRAPHICS ===
    gimp                      # GNU Image Manipulation Program - advanced image editor
    
    # === OFFICE PRODUCTIVITY ===
    libreoffice               # LibreOffice suite - complete office productivity suite (Writer, Calc, Impress)
    notion-app                # Notion - all-in-one workspace for notes, tasks, wikis, and databases
    
    # === DOCUMENT VIEWERS ===
    evince                    # GNOME document viewer for PDF, PostScript, and other formats
    
    # === ARCHIVE MANAGEMENT ===
    file-roller               # GNOME archive manager for creating and extracting compressed files
  ];
} 