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