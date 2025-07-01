{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # === NERD FONTS (NEW FORMAT) ===
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg  # Required for Powerlevel10k
    
    # === GOOGLE FONTS ===
    google-fonts
    
    # === SYSTEM FONTS ===
    inter
    roboto
    ubuntu_font_family
    liberation_ttf
    
    # === PROGRAMMING FONTS ===
    source-code-pro
    fira-code
    hack-font
    jetbrains-mono
  ];
} 