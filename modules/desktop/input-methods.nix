{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-unikey
      fcitx5-bamboo
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    # Thêm addon paths để fcitx5 tìm thấy addons
    FCITX_ADDON_DIRS = "${pkgs.fcitx5}/share/fcitx5/addon:${pkgs.fcitx5-unikey}/share/fcitx5/addon:${pkgs.fcitx5-bamboo}/share/fcitx5/addon";
  };
}
