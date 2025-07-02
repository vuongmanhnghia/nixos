{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # === NERD FONTS (NEW FORMAT) ===
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg  # Required for Powerlevel10k
    nerd-fonts.roboto-mono  # macOS-style monospace font
        
    # === SYSTEM FONTS (MACOS-STYLE) ===
    inter                 # Modern UI font (closest to San Francisco)
    roboto                # Google's modern system font family
    roboto-mono           # Roboto monospace font
    open-sans             # Popular modern web font
    ubuntu_font_family    # Ubuntu font family
    liberation_ttf        # Microsoft font replacements
    
    # === PROGRAMMING FONTS ===
    source-code-pro       # Adobe's monospace font
    fira-code             # Font with programming ligatures
    hack-font             # Clean monospace font
    jetbrains-mono        # JetBrains' monospace font
  ];
} 