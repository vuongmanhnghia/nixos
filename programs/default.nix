{ config, pkgs, ... }:

{
  # === APPLICATION CONFIGURATION MODULES ===
  imports = [
    ./development.nix  # Development tools (Docker, Git, programming languages, IDEs)
    ./gaming.nix       # Gaming platform (Steam, GameMode, controllers, Wine)
    ./multimedia.nix   # Multimedia applications (VLC, GIMP, LibreOffice, Vietnamese input)
  ];
} 