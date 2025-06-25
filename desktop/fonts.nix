{ config, pkgs, ... }:
{
  # === SYSTEM FONT CONFIGURATION ===
  fonts = {
    enableDefaultPackages = true;  # Enable default NixOS font packages
    
    # === FONT PACKAGES ===
    packages = with pkgs; [
      # === BASIC INTERNATIONAL FONTS ===
      noto-fonts              # Google's Noto font family (covers most Unicode)
      noto-fonts-cjk-sans     # Chinese, Japanese, Korean sans-serif fonts
      noto-fonts-cjk-serif    # Chinese, Japanese, Korean serif fonts
      noto-fonts-emoji        # Emoji font support
      liberation_ttf          # Liberation fonts (metric-compatible with Microsoft fonts)
      dejavu_fonts            # DejaVu font family (good Unicode coverage)
      
      # === PROGRAMMING AND MONOSPACE FONTS ===
      source-code-pro        # Adobe's monospace font for programming
      fira-code              # Monospace font with programming ligatures
      fira-code-symbols      # Additional symbols for Fira Code
      jetbrains-mono         # JetBrains' monospace font with ligatures
      
      # === VIETNAMESE LANGUAGE SUPPORT ===
      source-han-sans        # Adobe's pan-CJK font family (sans-serif)
      source-han-serif       # Adobe's pan-CJK font family (serif)
      
      # === ADDITIONAL MODERN FONTS ===
      ubuntu_font_family     # Ubuntu's default font family
      google-fonts           # Google Fonts collection
      
      # === NERD FONTS (WITH ICONS AND SYMBOLS) ===
      nerd-fonts.jetbrains-mono  # JetBrains Mono with developer icons
      nerd-fonts.fira-code       # Fira Code with developer icons
    ];

    # === FONT CONFIGURATION SETTINGS ===
    fontconfig = {
      enable = true;  # Enable fontconfig for font management
      
      # Default font fallback chain for different font types
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif" ];        # Serif fonts (formal documents)
        sansSerif = [ "Noto Sans" "Source Han Sans" ];      # Sans-serif fonts (UI, web)
        monospace = [ "JetBrains Mono" "Source Code Pro" ]; # Monospace fonts (code, terminal)
        emoji = [ "Noto Color Emoji" ];                     # Emoji rendering
      };
    };
  };
}
