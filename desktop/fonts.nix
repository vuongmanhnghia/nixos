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
      font-awesome 
      liberation_ttf          # Liberation fonts (metric-compatible with Microsoft fonts)
      dejavu_fonts            # DejaVu font family (good Unicode coverage)
      
      # === MACOS-STYLE FONTS ===
      adwaita-fonts          # Adwaita Sans (variation of Inter, closest to San Francisco Pro)
      roboto                 # Google's modern system font family (similar to San Francisco)
      open-sans              # Popular modern web font, great system font alternative
      aileron                # Helvetica font in nine weights (classic macOS look)
      manrope                # Modern sans-serif font family
      
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
      # Removed google-fonts to prevent Inconsolata conflict
    ];

    # === FONT CONFIGURATION SETTINGS ===
    fontconfig = {
      enable = true;  # Enable fontconfig for font management
      
      # Default font fallback chain for different font types (macOS-style)
      defaultFonts = {
        serif = [ "Adwaita Serif" "Roboto Serif" "Noto Serif" "Source Han Serif" ];        # Serif fonts (formal documents)
        sansSerif = [ "Adwaita Sans" "Roboto" "Open Sans" "Aileron" "Noto Sans" "Source Han Sans" ];      # Sans-serif fonts (UI, web) - macOS-like
        monospace = [ "JetBrains Mono" "Source Code Pro" ]; # Monospace fonts (code, terminal)
        emoji = [ "Noto Color Emoji" ];                     # Emoji rendering
      };
    };
  };
}
