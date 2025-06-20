# 🚀 NixOS 25.05 Professional Configuration

> **Optimized, Clean & High-Performance NixOS Setup**

[![NixOS](https://img.shields.io/badge/NixOS-25.05-blue.svg)](https://nixos.org/)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-lightblue.svg)](https://nixos.wiki/wiki/Flakes)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A professionally crafted, optimized NixOS configuration using flakes with comprehensive performance tuning, modular architecture, and automated maintenance tools.

## ✨ **Key Features**

### 🏗️ **Architecture**

-  **Flake-based** configuration with proper input management
-  **Modular design** with organized system/desktop separation
-  **Home Manager** integration for user-space management
-  **Hardware-specific** optimizations (NVIDIA, gaming, laptop/desktop)

### ⚡ **Performance Optimizations**

-  **Gaming-focused** kernel tuning and CPU scheduling
-  **I/O scheduler** optimization (NVMe, SSD, HDD detection)
-  **Network stack** tuning with BBR congestion control
-  **Memory management** with transparent hugepages
-  **Boot optimization** with parallel systemd and cleanup

### 🎮 **Gaming Excellence**

-  **Steam** with Proton-GE and compatibility tools
-  **GameMode** with custom performance profiles
-  **MangoHud** and performance monitoring
-  **Controller support** for Xbox, PlayStation, Nintendo
-  **Low-latency** audio and graphics optimization

### 🖥️ **Desktop Environment**

-  **GNOME** with curated extensions and optimizations
-  **NVIDIA** driver with proper power management
-  **Wayland** support with hardware acceleration
-  **Fonts** and theming for professional appearance

### 🛠️ **Developer Tools**

-  **Multiple dev shells** (Web, Python, general)
-  **Neovim** with comprehensive IDE setup
-  **VSCode** extensions through Nix
-  **Container support** with Docker

### 🔧 **System Management**

-  **Automated cleanup** and optimization scripts
-  **Health monitoring** and system analysis
-  **Performance profiling** and boot analysis
-  **Emergency recovery** commands
-  **Backup utilities** and generation management

## 📁 Project Structure

```
nixos/
├── flake.nix                 # Main flake configuration
├── flake.lock               # Flake lock file
├── Makefile                 # Development commands
├── README.md                # This file
├── .gitignore              # Git ignore rules
│
├── hosts/                   # Host-specific configurations
│   └── desktop/
│       ├── configuration.nix    # Main host configuration
│       ├── hardware-configuration.nix
│       ├── nvidia.nix           # NVIDIA-specific config
│       └── gaming.nix           # Gaming optimizations
│
├── modules/                 # Reusable NixOS modules
│   ├── system/             # System-level modules
│   │   ├── default.nix     # Module imports
│   │   ├── audio.nix       # Audio configuration
│   │   ├── bluetooth.nix   # Bluetooth support
│   │   ├── boot.nix        # Boot optimization
│   │   ├── docker.nix      # Docker containerization
│   │   ├── fonts.nix       # Font configuration
│   │   ├── locale.nix      # Localization settings
│   │   ├── networking.nix  # Network configuration
│   │   ├── performance.nix # Performance optimizations
│   │   ├── printing.nix    # Printer support
│   │   ├── security.nix    # Security hardening
│   │   └── syncthing.nix   # File synchronization
│   │
│   └── desktop/            # Desktop environment modules
│       ├── default.nix     # Module imports
│       ├── gnome.nix       # GNOME configuration
│       └── common.nix      # Common desktop packages
│
├── home/                   # Home Manager configurations
│   └── users/
│       └── nagih/          # User-specific config
│           ├── default.nix # Main home config
│           ├── desktop.nix # Desktop applications
│           └── neovim.nix  # Neovim configuration
│
└── scripts/                # Utility scripts
    ├── system-optimizer.sh # System optimization
    └── migrate.sh          # Migration helper
```

## 🚀 **Quick Start**

### Initial Setup

```bash
# Clone the repository
git clone <your-repo> ~/nixos-config
cd ~/nixos-config

# Install development dependencies
make install-deps

# Check configuration
make check

# Build and test
make build
make test

# Apply configuration
make switch
```

### Daily Usage

```bash
# Quick status check
make status

# System optimization
make optimize

# Check for updates
make check-updates

# Update and switch
make update

# Clean system
make clean
```

## 🛠️ **Available Commands**

### Core Operations

| Command       | Description                           |
| ------------- | ------------------------------------- |
| `make switch` | Build and switch to new configuration |
| `make build`  | Build configuration without switching |
| `make test`   | Test configuration without applying   |
| `make boot`   | Set as boot default (requires reboot) |

### Updates & Maintenance

| Command              | Description                           |
| -------------------- | ------------------------------------- |
| `make update`        | Update flake inputs and switch        |
| `make check-updates` | Check for available updates           |
| `make clean`         | Clean temporary files and caches      |
| `make clean-deep`    | Deep clean including old generations  |
| `make optimize`      | Run comprehensive system optimization |

### Performance & Gaming

| Command                 | Description                 |
| ----------------------- | --------------------------- |
| `make performance-mode` | Enable maximum performance  |
| `make gaming-on`        | Enable gaming optimizations |
| `make gaming-off`       | Return to power-save mode   |
| `make analyze-boot`     | Analyze boot performance    |

### Development

| Command           | Description                    |
| ----------------- | ------------------------------ |
| `make dev-shell`  | Enter development shell        |
| `make dev-web`    | Web development environment    |
| `make dev-python` | Python development environment |
| `make format`     | Format all Nix files           |
| `make lint`       | Lint Nix configurations        |

### Monitoring & Analysis

| Command              | Description                   |
| -------------------- | ----------------------------- |
| `make status`        | Show system overview          |
| `make check-health`  | Check system health           |
| `make system-info`   | Detailed system information   |
| `make system-report` | Generate comprehensive report |
| `make monitor`       | Real-time system monitoring   |
| `make monitor-gpu`   | NVIDIA GPU monitoring         |

### Backup & Recovery

| Command                 | Description                     |
| ----------------------- | ------------------------------- |
| `make backup-config`    | Backup current configuration    |
| `make list-generations` | Show system generations         |
| `make rollback`         | Rollback to previous generation |
| `make emergency-shell`  | Boot into emergency mode        |

## ⚡ **Performance Features**

### 🎯 **Gaming Optimizations**

-  **CPU governor** automatically set to performance for games
-  **Process scheduling** optimized for interactive workloads
-  **Memory overcommit** tuning for better game loading
-  **Network stack** optimized for online gaming latency
-  **I/O priority** for game processes via ananicy-cpp
-  **Real-time scheduling** for audio subsystem

### 🚄 **Boot Performance**

-  **Parallel systemd** initialization in initrd
-  **Silent boot** with minimal logging
-  **Timeout reduction** for faster startup
-  **Service optimization** with disabled unnecessary services
-  **Plymouth** for smooth boot animation

### 💾 **Storage Optimization**

-  **Automatic I/O scheduler** detection (none/mq-deadline/bfq)
-  **Read-ahead tuning** per storage type
-  **Filesystem** optimization with noatime and compression
-  **Tmpfs** for /tmp with size limits
-  **ZRAM** swap with zstd compression

### 🌐 **Network Performance**

-  **BBR congestion control** for better throughput
-  **CAKE qdisc** for fair queuing and latency
-  **Buffer tuning** for high-bandwidth applications
-  **TCP FastOpen** for reduced connection latency
-  **Network interface** optimization via udev rules

## 🔧 **System Optimizer Tool**

The included `system-optimizer.sh` script provides comprehensive system maintenance:

```bash
# Run all optimizations
./scripts/system-optimizer.sh --all

# Specific optimizations
./scripts/system-optimizer.sh --nix         # Nix store cleanup
./scripts/system-optimizer.sh --performance # Performance tuning
./scripts/system-optimizer.sh --clean       # Temporary file cleanup
./scripts/system-optimizer.sh --health      # System health check
```

Features:

-  ✅ **Automated Nix store** optimization and garbage collection
-  ✅ **Performance mode** activation with CPU and I/O tuning
-  ✅ **System health** monitoring with disk/memory/service checks
-  ✅ **Boot analysis** with systemd-analyze integration
-  ✅ **Comprehensive reporting** with detailed system information
-  ✅ **Cleanup automation** for logs, caches, and temporary files

## 🎮 **Gaming Setup**

### Supported Platforms

-  **Steam** with Proton and native Linux games
-  **Lutris** for Windows games and emulators
-  **Heroic** for Epic Games Store and GOG
-  **Wine** with latest compatibility layers

### Performance Tools

-  **GameMode** for automatic performance switching
-  **MangoHud** for performance overlay
-  **Goverlay** for MangoHud configuration GUI
-  **Controller support** for major gaming peripherals

### Optimization Features

-  **GPU scheduling** priority for games
-  **CPU governor** switching during gameplay
-  **Memory allocation** tuning for large games
-  **Network optimization** for online gaming

## 🔒 **Security & Hardening**

-  **Root login disabled** for improved security
-  **Firewall** properly configured with minimal open ports
-  **Kernel hardening** with KASLR and stack protection
-  **User privilege** separation with proper group membership
-  **SSH key authentication** with agent forwarding
-  **Audit logging** configurable for compliance needs

## 📊 **Monitoring & Maintenance**

### Automated Tasks

-  **Daily Nix store** optimization
-  **Weekly garbage** collection
-  **Boot entry** cleanup (keep 3 most recent)
-  **Log rotation** with size and time limits
-  **System health** checks with notifications

### Manual Tools

-  **Performance profiling** with perf and systemd-analyze
-  **Resource monitoring** with htop, btop, iotop
-  **Network analysis** with iperf3 and nethogs
-  **GPU monitoring** with nvidia-smi integration
-  **Storage testing** with fio and iozone

## 🔄 **Update Strategy**

### Safe Updates

1. **Check health** before updates: `make check-health`
2. **Backup configuration**: `make backup-config`
3. **Check available updates**: `make check-updates`
4. **Test updates**: `make build && make test`
5. **Apply updates**: `make update`
6. **Verify system**: `make status`

### Rollback Process

If issues occur after updates:

```bash
make rollback              # Quick rollback to previous generation
make list-generations      # See all available generations
sudo nixos-rebuild --rollback switch  # Emergency rollback
```

## 📚 **Documentation**

Generate system documentation:

```bash
make docs  # Creates docs/system-overview.md
```

The documentation includes:

-  Current system information
-  Flake input versions
-  Available commands
-  Configuration overview

## ⚠️ **Important Notes**

### Performance vs Security

Some optimizations disable security features for maximum performance:

-  CPU vulnerability mitigations disabled (`mitigations=off`)
-  Audit system disabled for lower overhead
-  Some kernel hardening features optional

For production systems, review and enable appropriate security features.

### Hardware Requirements

This configuration is optimized for:

-  **Modern x86_64** systems with multiple cores
-  **16GB+ RAM** for gaming and development
-  **NVMe/SSD storage** for optimal performance
-  **NVIDIA graphics** (AMD support can be added)

### Gaming Performance

The gaming optimizations may impact:

-  **Power consumption** (higher when gaming)
-  **Background task** priority (lower during games)
-  **System responsiveness** when not gaming (optimized for gaming workloads)

## 🤝 **Contributing**

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Test thoroughly with `make check` and `make test`
4. Commit changes (`git commit -m 'Add amazing feature'`)
5. Push to branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

-  **NixOS Community** for the excellent documentation and support
-  **Home Manager** project for user-space management
-  **Gaming on Linux** community for optimization insights
-  **Performance tuning** guides from various Linux experts

---

<div align="center">

**🚀 Optimized for Performance • 🎮 Built for Gaming • 💼 Designed for Productivity**

</div>
