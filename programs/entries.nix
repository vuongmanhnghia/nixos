{ config, pkgs, ... }:

let
  # === NOTION CONFIGURATION ===
  notion-app = pkgs.appimageTools.wrapType2 {
    pname = "notion-app";
    name = "notion-app";
    version = "2.3.2-1";
    src = pkgs.fetchurl {
      url = "https://github.com/kidonng/notion-appimage/releases/download/2.3.2-1/Notion-2.3.2-1-x86-64.AppImage";
      sha256 = "06ki585zpdzsljknal6by6dac24r6r82w844h70ngzqf6y7lwxgy";
    };
    extraPkgs = pkgs: with pkgs; [ ];
  };

  notionDesktopItem = pkgs.makeDesktopItem {
    name = "notion-app";
    desktopName = "Notion";
    exec = "notion-app";
    icon = "notion";
    terminal = false;
    categories = [ "Office" "Development" ];
    startupWMClass = "Notion";
    mimeTypes = [ "x-scheme-handler/notion" ];
  };

  # === CURSOR CONFIGURATION ===
  cursorDesktopItem = pkgs.makeDesktopItem {
    name = "cursor-wayland";
    desktopName = "Cursor (Wayland)";
    exec = "cursor --disable-gpu";
    terminal = false;
    categories = [ "Development" "IDE" ];
    startupWMClass = "cursor";
    icon = "cursor";
  };
in
{
  environment.systemPackages = with pkgs; [
    notionDesktopItem
    cursorDesktopItem
    notion-app
  ];
}