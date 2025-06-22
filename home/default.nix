{ config, pkgs, ... }:

{
  # Import editor configurations
  imports = [
    ./editors/neovim.nix
  ];

  # Essential development tools
  home.packages = with pkgs; [
    # Development essentials
    python3
    
    # Development tools
    docker
    git
    
    # Terminal utilities
    ripgrep
    fd
    eza
    bat
    fzf
    tree
    unzip
    zip
    
    # System utilities
    neofetch
    btop
  ];

  # Git configuration (global defaults)
  programs.git = {
    enable = true;
    # User-specific config will be overridden in user files
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    # Common aliases
    shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      ls = "eza";
      grep = "rg";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
      cls = "clear";

      config = "cd /etc/nixos";
      nixos-rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
      home-rebuild = "home-manager switch --flake /etc/nixos";
    };
    
    # Bash prompt customization
    bashrcExtra = ''
      # Custom prompt
      export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      
      # History settings
      export HISTSIZE=10000
      export HISTFILESIZE=10000
      export HISTCONTROL=ignoredups:erasedups
      
      # Make history append, not overwrite
      shopt -s histappend
    '';
  };

  # Development environment
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # SSH configuration
  programs.ssh = {
    enable = true;
    
    # Common SSH settings
    extraConfig = ''
      Host *
        AddKeysToAgent yes
    '';
  };

  # Home Manager version
  home.stateVersion = "25.05";
}
