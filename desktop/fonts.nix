# nixos/fonts.nix (giữ nguyên + bổ sung)
{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # === BASIC FONTS ===
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      dejavu_fonts
      
      # === MODERN UI FONTS ===
      inter                    
      roboto
      open-sans
      aileron
      ubuntu_font_family
      
      # === PROGRAMMING FONTS ===
      source-code-pro
      fira-code
      jetbrains-mono
      hack-font               
      
      # === NERD FONTS ===
      nerd-fonts.inconsolata
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      nerd-fonts.roboto-mono
      
      # === VIETNAMESE SUPPORT ===
      source-han-sans
      source-han-serif
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Adwaita Serif" "Roboto Serif" "Noto Serif" ];
        sansSerif = [ "Inter" "Roboto" "Open Sans" "Noto Sans" ];
        monospace = [ "JetBrains Mono Nerd Font" "Source Code Pro" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}