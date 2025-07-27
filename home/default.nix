{ config, pkgs, ... }:

{
  # === SHARED HOME MANAGER CONFIGURATIONS ===
  # Import common configurations used by all users
  imports = [
    ./shared/fonts.nix           # Fonts
    ./shared/git.nix             # Git version control configuration
    ./shared/zsh.nix             # Zsh shell with aliases and modern CLI tools
    ./shared/tmux.nix            # Terminal multiplexer configuration
    ./shared/neovim.nix          # Neovim editor configuration with LSP
    ./shared/waybar.nix          # Waybar status bar configuration
    ./shared/gtk-theme.nix       # GTK theme configuration (Phase 2)
    ./shared/viegphunt-scripts.nix # ViegPhunt scripts (Phase 2)
    ./shared/wlogout.nix
    ./shared/swaync.nix
  ];

  # === ESSENTIAL PACKAGES FOR ALL USERS ===
  home.packages = with pkgs; [
    # === DEVELOPMENT ESSENTIALS ===
    python3    # Python 3 interpreter for scripting and development
    
    # === MODERN TERMINAL UTILITIES ===
    ripgrep    # Fast text search tool (better grep replacement)
    fd         # Fast and user-friendly alternative to find
    eza        # Modern ls replacement with better formatting and colors
    bat        # Syntax-highlighted cat replacement with paging
    fzf        # Fuzzy finder for files, commands, and history
    tree       # Display directory structures in tree format
    unzip      # Extract ZIP archives
    zip        # Create ZIP archives
    
    # === SYSTEM MONITORING UTILITIES ===
    neofetch   # System information display tool with ASCII art
    btop       # Modern system monitor with better interface than htop
    htop       # Interactive process viewer and system monitor
    
    # === WAYLAND CLIPBOARD UTILITIES ===
    wl-clipboard  # Wayland clipboard utilities (wl-copy, wl-paste)
  ];

  # === SSH CONFIGURATION ===
  programs.ssh = {
    enable = true;  # Enable SSH client
    
    # SSH agent configuration for key management
    extraConfig = ''
      AddKeysToAgent yes  # Automatically add SSH keys to agent
      IdentityFile ~/.ssh/id_ed25519  # Default SSH key file
      Host *
        AddKeysToAgent yes  # Automatically add SSH keys to agent
    '';
  };

  # === GHOSTTY CONFIGURATION ===
  home.file.".config/ghostty/config" = {
    source = ../dotfiles/ghostty/config;
  };

  # === CAVA CONFIGURATION ===
  home.file.".config/cava/config" = {
    source = ../dotfiles/cava/config;
  };

  # === HOME MANAGER VERSION ===
  home.stateVersion = "25.05";  # Should match your NixOS release version
}
