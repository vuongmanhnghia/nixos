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
    rustc
    
    # Development tools
    docker
    git
    
    # Terminal utilities
    ripgrep
    fd
    bat
    exa
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
      ll = "exa -la";
      la = "exa -a";
      ls = "exa";
      grep = "rg";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
      nixos-rebuild = "sudo nixos-rebuild switch --flake .";
      home-rebuild = "home-manager switch --flake .";
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
        UseKeychain yes
    '';
  };

  # Home Manager version
  home.stateVersion = "25.05";
}
