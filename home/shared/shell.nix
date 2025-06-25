{ config, pkgs, ... }:

{
  # === BASH SHELL CONFIGURATION ===
  programs.bash = {
    enable = true;
    
    # === COMMAND ALIASES FOR PRODUCTIVITY ===
    shellAliases = {
      # === FILE LISTING SHORTCUTS ===
      ll = "ls -alF";    # Long listing with file types
      la = "ls -A";      # List all files except . and ..
      l = "ls -CF";      # List in columns with file type indicators
      
      # === GIT SHORTCUTS ===
      gst = "git status";        # Quick git status
      gco = "git checkout";      # Quick git checkout
      gcp = "git cherry-pick";   # Quick git cherry-pick
      
      # === SYSTEM MANAGEMENT SHORTCUTS ===
      nixos-rebuild = "sudo nixos-rebuild switch --flake .";  # Rebuild NixOS system
      home-rebuild = "home-manager switch --flake .";         # Rebuild Home Manager config
      
      # === DEVELOPMENT NAVIGATION ===
      dev = "cd ~/Workspaces/Dev";              # Navigate to development directory
      nixconfig = "cd ~/Workspaces/Config/nixos"; # Navigate to NixOS configuration
      
      # === MODERN CLI TOOL REPLACEMENTS ===
      ls = "eza";     # Use eza instead of ls (better formatting and colors)
      cat = "bat";    # Use bat instead of cat (syntax highlighting)
      grep = "rg";    # Use ripgrep instead of grep (faster searching)
      find = "fd";    # Use fd instead of find (faster and more intuitive)
    };

    # === BASH CONFIGURATION EXTRAS ===
    bashrcExtra = ''
      # === CUSTOM COMMAND PROMPT ===
      export PS1="\[\e[32m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[m\]\$ "
      
      # === DEVELOPMENT ENVIRONMENT VARIABLES ===
      export EDITOR="nvim"           # Set Neovim as default editor
      export BROWSER="google-chrome" # Set Google Chrome as default browser
      export TERMINAL="gnome-terminal" # Set GNOME Terminal as default terminal
    '';
  };

  # === DIRECTORY ENVIRONMENT MANAGEMENT ===
  programs.direnv = {
    enable = true;                # Enable direnv for automatic environment loading
    enableBashIntegration = true; # Integrate direnv with Bash shell
    nix-direnv.enable = true;     # Enable Nix integration for direnv (automatic nix-shell)
  };
} 