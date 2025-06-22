{ config, pkgs, ... }:

{
  # === INPUT METHODS CONFIGURATION - NIXOS 25.05 ===
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-unikey
      fcitx5-bamboo
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  # Input method environment variables - compatible with environment.nix
  environment.sessionVariables = {
    # Fcitx5 integration
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    
    # Wayland specific - Fixed package name
    QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6Packages.fcitx5-qt}/lib/qt-6/plugins/platforminputcontexts";
    
    # Addon paths for proper fcitx5 functionality
    FCITX_ADDON_DIRS = "${pkgs.fcitx5}/share/fcitx5/addon:${pkgs.fcitx5-unikey}/share/fcitx5/addon:${pkgs.fcitx5-bamboo}/share/fcitx5/addon";
  };
  
  # Additional packages for Vietnamese input
  environment.systemPackages = with pkgs; [
    fcitx5-configtool
    fcitx5-unikey
    fcitx5-bamboo
    qt6Packages.fcitx5-qt  # Add the correct Qt6 package
  ];
}
