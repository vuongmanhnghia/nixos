{ config, pkgs, ... }:

{
  # === SHARED HOME MANAGER CONFIGURATIONS ===
  # Import common configurations used by all users
  imports = [
    ./shared/hypr/default.nix    # Hyprland configuration
    ./shared/matugen/default.nix # Matugen configuration
    ./shared/waybar/default.nix  # Waybar configuration
    ./shared/swaync/default.nix  # Swaync configuration
    ./shared/rofi/default.nix    # Rofi configuration
    ./shared/fonts.nix           # Fonts
    ./shared/git.nix             # Git version control configuration
    ./shared/zsh.nix             # Zsh shell with aliases and modern CLI tools
    ./shared/neovim.nix          # Neovim editor configuration with LSP
    ./shared/gtk-theme.nix       # GTK theme configuration (Phase 2)
    ./shared/kitty.nix           # Kitty terminal configuration
    ./shared/fastfetch.nix       # Fastfetch configuration
    ./shared/ripgrep.nix         # Ripgrep configuration
    ./shared/wlogout/default.nix # Wlogout configuration
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

  # === WLOUT CONFIGURATION ===
  # home.file.".config/wlogout" = {
  #   source = ../dotfiles/wlogout;
  #   recursive = true;
  # };

  # === TMUX CONFIGURATION ===
  programs.tmux = {
    enable = true;
    
    # Use the existing tmux.conf file
    extraConfig = builtins.readFile ../dotfiles/tmux/tmux.conf;
    
    # Enable plugins that are referenced in the config
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
  };
  home.file.".config/tmux/random_note.sh" = {
    source = ../dotfiles/tmux/random_note.sh;
    executable = true;
  };

  # === CAVA CONFIGURATION ===
  home.file.".config/cava/config" = {
    source = /home/nagih/Workspaces/Config/nixos/colors/cava.config;
  };

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

  # === HOME MANAGER VERSION ===
  home.stateVersion = "25.05";  # Should match your NixOS release version
}
