{ config, pkgs, ... }:

{
  # Media applications
  home.packages = with pkgs; [
    # Video players
    vlc
    mpv
    
    # Audio
    pavucontrol
    audacity
    
    # Image viewers and editors
    eog # GNOME image viewer
    gimp
    
    # Media tools
    ffmpeg
    imagemagick
    
    # Streaming
    spotify
  ];
  
  # Media configurations
  home.sessionVariables = {
    # Video acceleration
    LIBVA_DRIVER_NAME = "nvidia";
  };
  
  # XDG mime associations
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "audio/mpeg" = "vlc.desktop";
      "audio/x-wav" = "vlc.desktop";
      "image/jpeg" = "eog.desktop";
      "image/png" = "eog.desktop";
    };
  };
} 