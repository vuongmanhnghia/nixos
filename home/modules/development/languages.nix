{ config, pkgs, ... }:

{
  # Programming languages and runtimes
  home.packages = with pkgs; [    
    # Python
    python3
    python3Packages.pip
  ];
  
  # Language-specific configurations
  home.sessionVariables = {    
    # Python
    PYTHONDONTWRITEBYTECODE = "1";
    PIP_REQUIRE_VIRTUALENV = "true";
  };
} 