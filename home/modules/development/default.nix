{ config, pkgs, extensions, ... }:

{
  imports = [
    ./editors.nix
    ./languages.nix
    ./tools.nix
  ];
  
  # Development packages - avoid duplicates with other modules
  home.packages = with pkgs; [
    # Version control (not git itself - that's in base)
    gitui
    gh # GitHub CLI
    
    # Containers
    docker-compose
    
    # API testing
    postman
    
    # Essential development tools
    wget
    curl
    unzip
    zip
    p7zip
  ];
  
  # Direnv for project environments
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  
  # Modern terminal tools
  programs = {
    # Better cat
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        style = "numbers,changes,header";
      };
    };
    
    # Better ls
    eza = {
      enable = true;
      enableBashIntegration = true;
    };
    
    # Better find
    fd.enable = true;
    
    # Better grep
    ripgrep.enable = true;
    
    # Fuzzy finder
    fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
    };
    
    # JSON processor
    jq.enable = true;
  };
} 