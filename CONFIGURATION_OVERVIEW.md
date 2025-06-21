# 📁 NixOS Configuration Overview

## 🏗️ **Directory Structure**

```
nixos/
├── 📄 flake.nix                    # Main flake configuration
├── 📄 configuration.nix            # Core system settings
├── 📄 hardware-configuration.nix   # Hardware-specific config
├── 📄 secrets.nix                  # Sensitive data (git-ignored)
├── 📄 secrets.nix.example          # Template for secrets
├── 📄 .gitignore                   # Git ignore rules
├── 📄 SECRETS_SETUP.md             # Secrets setup guide
├── 📄 CONFIGURATION_OVERVIEW.md    # This file
│
├── 📁 modules/                     # System modules
│   ├── 📁 system/                  # Core system configuration
│   │   ├── 📄 default.nix          # System modules import
│   │   ├── 📄 boot.nix             # Boot configuration
│   │   ├── 📄 networking.nix       # Network settings
│   │   ├── 📄 locale.nix           # Localization
│   │   ├── 📄 security.nix         # Security settings
│   │   └── 📄 users.nix            # User accounts
│   │
│   ├── 📁 desktop/                 # Desktop environment
│   │   ├── 📄 default.nix          # Desktop modules import
│   │   ├── 📄 xserver.nix          # X11 configuration
│   │   ├── 📄 nvidia.nix           # NVIDIA drivers
│   │   ├── 📄 gnome.nix            # GNOME desktop
│   │   ├── 📄 input-methods.nix    # Input methods (fcitx5)
│   │   ├── 📄 audio.nix            # Audio configuration
│   │   ├── 📄 fonts.nix            # Font configuration
│   │   └── 📄 gaming.nix           # Gaming setup (Steam)
│   │
│   └── 📁 services/                # System services
│       ├── 📄 default.nix          # Services import
│       ├── 📄 docker.nix           # Docker configuration
│       └── 📄 development.nix      # Development tools
│
├── 📁 home/                        # Home-manager configuration
│   ├── 📁 common/                  # Shared configurations
│   │   ├── 📄 default.nix          # Common imports
│   │   ├── 📄 git.nix              # Git configuration
│   │   ├── 📄 shell.nix            # Shell & SSH setup
│   │   └── 📁 neovim/              # Neovim configuration
│   │       ├── 📄 default.nix      # Neovim plugins & packages
│   │       └── 📄 config.lua       # Neovim Lua config
│   │
│   └── 📁 profiles/                # User-specific profiles
│       ├── 📄 nagih.nix            # Main user profile
│       └── 📄 newuser.nix          # Example additional user
│
└── 📁 lib/                         # Helper libraries
    └── 📄 secrets-helper.nix       # Secrets management
```

## 🔧 **Key Features**

### ✅ **Modular Architecture**

-  **System modules**: Core system configuration split by functionality
-  **Desktop modules**: Desktop environment and related services
-  **Service modules**: Individual service configurations
-  **Home profiles**: Per-user home-manager configurations
-  **Common configs**: Reusable home-manager modules

### 🔒 **Secrets Management**

-  **Git-ignored secrets**: `secrets.nix` never committed
-  **Fallback values**: System works without secrets file
-  **Template provided**: `secrets.nix.example` for setup
-  **Safe loading**: Helper library prevents crashes

### 🎮 **Optimized for Gaming**

-  **Steam integration**: Proper Steam setup with GameMode
-  **NVIDIA drivers**: Hardware-accelerated graphics
-  **Audio**: PipeWire for low-latency audio
-  **Performance**: Optimized kernel and services

### 💻 **Development-Ready**

-  **Neovim**: Full IDE setup with LSP, completion, plugins
-  **Docker**: Containerization with auto-pruning
-  **Git**: Configured with modern defaults
-  **Shell**: Enhanced Bash with useful aliases
-  **SSH**: Proper agent and key management

### 🌐 **Modern Desktop**

-  **GNOME**: Latest GNOME with useful extensions
-  **Wayland**: Modern display protocol
-  **Input methods**: Vietnamese input support
-  **Fonts**: Beautiful typography setup
-  **Themes**: Consistent visual experience

## 🚀 **Usage Commands**

```bash
# Build and switch to new configuration
sudo nixos-rebuild switch --flake /etc/nixos

# Test configuration without switching
sudo nixos-rebuild test --flake /etc/nixos

# Check flake for errors
nix flake check

# Update all inputs
nix flake update

# Clean old generations
sudo nix-collect-garbage -d
```

## 📝 **Adding New Users**

1. Create new profile in `home/profiles/username.nix`
2. Add user to `modules/system/users.nix`
3. Import profile in `flake.nix` under `home-manager.users`

## 🔄 **Updating System**

1. Update flake inputs: `nix flake update`
2. Test changes: `sudo nixos-rebuild test --flake /etc/nixos`
3. Apply changes: `sudo nixos-rebuild switch --flake /etc/nixos`
4. Commit changes: `git add . && git commit -m "Update system"`

## 🛠️ **Customization**

-  **Add packages**: Edit relevant module files
-  **Change desktop**: Modify `modules/desktop/` files
-  **Add services**: Create new files in `modules/services/`
-  **User configs**: Edit files in `home/profiles/`
-  **Secrets**: Update `secrets.nix` (never commit!)

## 📚 **Documentation**

-  `SECRETS_SETUP.md`: How to set up secrets
-  Individual module files: Well-commented configurations
-  NixOS Manual: https://nixos.org/manual/nixos/stable/
-  Home Manager Manual: https://nix-community.github.io/home-manager/
