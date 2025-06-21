# NixOS Configuration

A clean, modular NixOS configuration optimized for development and desktop use.

## 📁 Structure

```
├── configuration.nix          # Main system configuration
├── hardware-configuration.nix # Hardware-specific settings
├── flake.nix                 # Flake configuration with inputs
│
├── modules/
│   ├── system/               # System-level configurations
│   │   ├── default.nix       # System module imports
│   │   ├── users.nix         # User accounts and groups
│   │   ├── packages.nix      # System packages
│   │   ├── firewall.nix      # Firewall rules
│   │   ├── boot.nix          # Boot configuration
│   │   ├── networking.nix    # Network settings
│   │   ├── locale.nix        # Locale and timezone
│   │   └── security.nix      # Security settings
│   │
│   └── desktop/              # Desktop environment configurations
│       ├── default.nix       # Desktop module imports
│       ├── gaming.nix        # Steam and gaming setup
│       ├── gnome.nix         # GNOME desktop environment
│       ├── xserver.nix       # X11 configuration
│       ├── nvidia.nix        # NVIDIA drivers
│       ├── audio.nix         # Audio configuration
│       ├── fonts.nix         # System fonts
│       └── input-methods.nix # Input methods
│
└── home/                     # Home Manager configurations
    ├── default.nix           # Common home configuration
    ├── nagih.nix            # User-specific configuration
    ├── newuser.nix          # Template for new users
    │
    └── editors/              # Editor configurations
        └── neovim.nix        # Neovim setup with plugins
```

## 🚀 Usage

### System Rebuild

```bash
sudo nixos-rebuild switch --flake .
```

### Home Manager Rebuild

```bash
home-manager switch --flake .
```

### Quick Aliases (available after rebuild)

```bash
nixos-rebuild    # System rebuild shortcut
home-rebuild     # Home Manager rebuild shortcut
dev             # cd ~/Workspaces/Dev
nixconfig       # cd to this config directory
```

## ⚙️ Features

### System Configuration

-  **Modular design**: Each component is separated into logical modules
-  **User management**: Clean user and group configuration
-  **Security**: Proper firewall rules and security settings
-  **Gaming ready**: Steam and gaming tools configured
-  **Development tools**: Docker, Git, and essential dev packages

### Home Manager

-  **Neovim**: Fully configured with LSP, completion, and modern keybindings
-  **Development environment**: Node.js, Python, Rust, Go toolchains
-  **Syncthing**: File synchronization (configure device IDs)
-  **Modern shell**: Bash with useful aliases and prompt
-  **Terminal tools**: ripgrep, fd, bat, exa, and more

### Editor (Neovim)

-  **LSP support**: Language servers for major languages
-  **Modern keybindings**: Familiar Ctrl+C/V/A shortcuts
-  **Rich plugins**: File explorer, fuzzy finder, Git integration
-  **Multiple colorschemes**: Tokyo Night and Catppuccin

## 🛡️ Security Notes

-  Root login is disabled
-  SSH agent configured properly
-  Syncthing password should be set via web interface (not hardcoded)
-  Replace device IDs in `home/nagih.nix` with actual device IDs

## 🔧 Adding New Users

1. Copy `home/newuser.nix` to `home/username.nix`
2. Update the user configuration
3. Add to `flake.nix` home-manager users section
4. Add user to `modules/system/users.nix`

## 🎨 Customization

### Adding System Packages

Add to `modules/system/packages.nix`

### Adding User Packages

Add to specific user files in `home/`

### Desktop Environment Changes

Modify files in `modules/desktop/`

### Gaming Configuration

Edit `modules/desktop/gaming.nix`

This configuration follows NixOS best practices and is designed for easy maintenance and extension.

### AFTER BUILD SUSSCESS

{ config, pkgs, ... }:

{

# User accounts

users.users = {
nagih = {
isNormalUser = true;
description = "Nagih";
extraGroups = [ "networkmanager" "wheel" "docker" "audio" "video" ];
shell = pkgs.bash; # CRITICAL: Set initial password for first setup
initialPassword = "changeme"; # CHANGE THIS AFTER FIRST LOGIN!
};

    # Root user configuration
    # CRITICAL: Keep root enabled for emergency access on fresh installs
    root = {
      # Allow root login for emergency access during setup
      initialPassword = "root";  # CHANGE THIS AFTER SETUP!
      # hashedPassword = "!";  # Enable this ONLY after confirming user access works
    };

};

# User groups

users.groups = {
docker = {};
};
}
