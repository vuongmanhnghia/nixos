{ config, pkgs, ... }:

{
  # === SHARED HOME MANAGER CONFIGURATIONS ===
  # Import common configurations used by all users
  imports = [
    ./shared/fonts.nix           # Fonts
    ./shared/git.nix             # Git version control configuration
    ./shared/bash.nix            # Bash shell with aliases and modern CLI tools
    ./shared/zsh.nix             # Zsh shell with aliases and modern CLI tools
    ./shared/tmux.nix            # Terminal multiplexer configuration
    ./shared/wezterm.nix         # WezTerm terminal emulator configuration
    ./shared/gnome.nix           # GNOME desktop user settings and themes
    ./shared/neovim.nix          # Neovim editor configuration with LSP
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
      Host *
        AddKeysToAgent yes  # Automatically add SSH keys to agent
    '';
  };

  # === HOME MANAGER VERSION ===
  home.stateVersion = "25.05";  # Should match your NixOS release version
}
