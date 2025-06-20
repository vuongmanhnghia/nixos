{ config, pkgs, ... }:

{
  # Productivity applications
  home.packages = with pkgs; [
    # Office suite
    # libreoffice
    
    # PDF tools
    # kdePackages.okular
  ];
  
  # Productivity-focused configurations
  xdg.configFile = {
    "Code/User/settings.json".text = builtins.toJSON {
      "workbench.colorTheme" = "Default Dark+";
      "editor.fontSize" = 14;
      "editor.fontFamily" = "JetBrains Mono";
      "editor.fontLigatures" = true;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
    };
  };
} 