# NixOS Configuration - Simplified & Optimized

Cấu hình NixOS được tối ưu hóa, đơn giản và dễ maintain cho development và desktop.

## 📁 Cấu trúc

```
nixos-config/
├── flake.nix                    # Core flake configuration
├── configuration.nix            # Main system config
├── hardware-configuration.nix   # Hardware-specific settings
│
├── system/                      # System-level configurations
│   ├── default.nix             # System imports
│   ├── boot.nix                # Boot configuration
│   ├── users.nix               # User management
│   ├── networking.nix          # Network basics
│   ├── locale.nix              # Timezone & language
│   ├── packages.nix            # Essential system packages
│   └── security.nix            # Basic security settings
│
├── desktop/                     # Desktop environment
│   ├── default.nix             # Desktop imports
│   ├── gnome.nix               # GNOME desktop
│   ├── audio.nix               # PipeWire audio
│   ├── graphics.nix            # NVIDIA graphics (latest)
│   └── fonts.nix               # System fonts
│
├── programs/                    # Application configurations
│   ├── default.nix             # Program imports
│   ├── development.nix         # Dev tools & Docker
│   ├── gaming.nix              # Gaming (Steam, GameMode)
│   └── multimedia.nix          # Media apps & Vietnamese input
│
└── home/                        # Home Manager configurations
    ├── default.nix             # Common home config (imports all shared)
    ├── nagih.nix               # User-specific config
    ├── newuser.nix             # Template for new users
    └── shared/                 # Shared configurations
        ├── git.nix             # Git configuration
        ├── shell.nix           # Bash & aliases
        ├── tmux.nix            # Tmux configuration (simplified)
        ├── gnome.nix           # GNOME user settings (simplified)
        └── editors/            # Editor configs
            └── neovim.nix      # Neovim setup
```

## 🚀 Sử dụng

### Rebuild System

```bash
sudo nixos-rebuild switch --flake .
```

### Rebuild Home Manager

```bash
home-manager switch --flake .
```

### Quick Commands

```bash
nixos-rebuild    # System rebuild
home-rebuild     # Home Manager rebuild
dev              # cd ~/Workspaces/Dev
config           # cd to config directory
```

## ✨ Tính năng

### System

-  ✅ **Modular design** - Dễ extend và maintain
-  ✅ **NVIDIA latest driver** - Stable và performance
-  ✅ **PipeWire audio** - Low latency (0.67ms)
-  ✅ **Gaming support** - Steam, GameMode
-  ✅ **Development tools** - Docker, Git, modern CLI tools

### Home Manager

-  ✅ **Neovim** - LSP và modern keybindings
-  ✅ **Modern shell** - Bash với aliases hữu ích
-  ✅ **Syncthing** - File synchronization
-  ✅ **GNOME** - Desktop environment tối ưu

### Gaming

-  ✅ **Steam** - Native Wayland support
-  ✅ **GameMode** - Performance optimization
-  ✅ **Controller support** - PS4/PS5, Xbox, Nintendo

## 🔧 Customization

### Thêm System Packages

Edit `system/packages.nix`

### Thêm User Packages

Edit `home/nagih.nix` hoặc `home/default.nix`

### Gaming Configuration

Edit `programs/gaming.nix`

### Desktop Changes

Edit files trong `desktop/`

## 🛡️ Security Notes

-  Root login disabled
-  SSH key authentication only
-  Firewall enabled với ports cần thiết
-  Syncthing chạy local only

## 🆕 Adding New Users

1. Copy `home/nagih.nix` thành `home/username.nix`
2. Update user config
3. Add vào `flake.nix` home-manager users section
4. Add user vào `system/users.nix`

## 📦 Syncthing Alternative

### Current: Syncthing

-  ✅ P2P, no cloud dependency
-  ✅ End-to-end encryption
-  ❌ No web interface for file management

### Alternative: Nextcloud (Recommended)

```nix
# Add to programs/multimedia.nix
services.nextcloud-client.enable = true;
```

**Lợi ích:**

-  🌐 Web interface
-  📱 Mobile apps tốt hơn
-  🔒 Better permission control
-  📊 Activity monitoring
-  🔄 Version history with web UI

**Setup Nextcloud:**

1. Tạo account trên Nextcloud provider
2. Install Nextcloud desktop client
3. Sync folders tương tự Syncthing

Bạn có muốn tôi thay Syncthing bằng Nextcloud không?

---

_Configuration simplified từ complex setup, giữ lại functionality cần thiết_
