{ config, pkgs, ... }:

{
  # === APPLICATION CONFIGURATION MODULES ===
  imports = [
    ./development.nix  # Development tools (Docker, Git, programming languages, IDEs)
    ./python.nix       # Python development environment and tools
    ./golang.nix       # Go development environment and tools
    ./gaming.nix       # Gaming platform (Steam, GameMode, controllers, Wine)
    ./multimedia.nix   # Multimedia applications (VLC, GIMP, LibreOffice, Vietnamese input)
  ];
  
  # === SHELL CONFIGURATION ===
  programs.zsh.enable = true;  # Enable zsh shell with proper PATH configuration
} 