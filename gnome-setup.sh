#!/usr/bin/env bash

# GNOME Modern Setup Script for NixOS
# Script để thiết lập GNOME hiện đại với best practices

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on NixOS
check_nixos() {
    if ! command -v nixos-rebuild &> /dev/null; then
        print_error "This script is designed for NixOS. Please run on a NixOS system."
        exit 1
    fi
}

# Check if GNOME is available
check_gnome() {
    if ! command -v gnome-shell &> /dev/null; then
        print_warning "GNOME Shell not found. Will be installed during rebuild."
    fi
}

# Backup current configuration
backup_config() {
    print_status "Tạo backup cấu hình hiện tại..."
    
    # Backup current GNOME settings
    if command -v dconf &> /dev/null; then
        mkdir -p ~/backups/gnome
        dconf dump /org/gnome/ > ~/backups/gnome/gnome-settings-$(date +%Y%m%d-%H%M%S).txt
        print_success "Đã backup cấu hình GNOME vào ~/backups/gnome/"
    fi
    
    # Backup current NixOS configuration
    if [ -f /etc/nixos/configuration.nix ]; then
        sudo cp /etc/nixos/configuration.nix ~/backups/nixos-configuration-$(date +%Y%m%d-%H%M%S).nix
        print_success "Đã backup cấu hình NixOS"
    fi
}

# Apply NixOS configuration
apply_nixos_config() {
    print_status "Áp dụng cấu hình NixOS..."
    
    if sudo nixos-rebuild switch --flake .#nixos; then
        print_success "Đã áp dụng cấu hình NixOS thành công!"
    else
        print_error "Lỗi khi áp dụng cấu hình NixOS"
        exit 1
    fi
}

# Apply Home Manager configuration
apply_home_manager() {
    print_status "Áp dụng cấu hình Home Manager..."
    
    if command -v home-manager &> /dev/null; then
        if home-manager switch --flake .#nagih; then
            print_success "Đã áp dụng cấu hình Home Manager thành công!"
        else
            print_error "Lỗi khi áp dụng cấu hình Home Manager"
            exit 1
        fi
    else
        print_warning "Home Manager chưa được cài đặt"
    fi
}

# Install and enable GNOME extensions
setup_extensions() {
    print_status "Thiết lập GNOME Extensions..."
    
    # Wait for GNOME to be available
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        # Enable essential extensions
        EXTENSIONS=(
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "dash-to-dock@micxgx.gmail.com"
            "appindicatorsupport@rgcjonas.gmail.com"
            "Vitals@CoreCoding.com"
            "clipboard-indicator@tudmotu.com"
            "blur-my-shell@aunetx"
            "just-perfection-desktop@just-perfection"
            "space-bar@luchrioh"
            "caffeine@patapon.info"
            "tiling-assistant@leleat-on-github"
        )
        
        for ext in "${EXTENSIONS[@]}"; do
            if gnome-extensions show "$ext" &> /dev/null; then
                gnome-extensions enable "$ext"
                print_success "Đã bật extension: $ext"
            else
                print_warning "Extension không tìm thấy: $ext"
            fi
        done
    else
        print_warning "Không trong phiên GNOME. Extensions sẽ được bật khi đăng nhập GNOME."
    fi
}

# Optimize GNOME performance
optimize_performance() {
    print_status "Tối ưu hóa hiệu suất GNOME..."
    
    # Apply performance-focused dconf settings
    if command -v dconf &> /dev/null; then
        # Enable smooth animations but optimize for performance
        dconf write /org/gnome/desktop/interface/enable-animations true
        dconf write /org/gnome/mutter/dynamic-workspaces true
        dconf write /org/gnome/mutter/experimental-features "['scale-monitor-framebuffer', 'rt-scheduler']"
        
        # Optimize shell performance
        dconf write /org/gnome/shell/enable-hot-corners false
        
        # Set modern font rendering
        dconf write /org/gnome/desktop/interface/font-antialiasing "'rgba'"
        dconf write /org/gnome/desktop/interface/font-hinting "'slight'"
        
        print_success "Đã áp dụng tối ưu hóa hiệu suất"
    fi
}

# Verify installation
verify_installation() {
    print_status "Kiểm tra cài đặt..."
    
    # Check if GNOME is running
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        print_success "GNOME đang chạy"
        
        # Check GNOME Shell version
        GNOME_VERSION=$(gnome-shell --version 2>/dev/null || echo "Unknown")
        print_status "GNOME Shell version: $GNOME_VERSION"
        
        # Check enabled extensions
        ENABLED_EXTENSIONS=$(gnome-extensions list --enabled 2>/dev/null | wc -l)
        print_status "Số lượng extensions đã bật: $ENABLED_EXTENSIONS"
        
    else
        print_warning "GNOME chưa chạy. Vui lòng logout và login lại để sử dụng GNOME."
    fi
    
    # Check if required packages are installed
    PACKAGES=("gnome-tweaks" "dconf-editor" "nautilus" "gnome-terminal")
    for pkg in "${PACKAGES[@]}"; do
        if command -v "$pkg" &> /dev/null; then
            print_success "$pkg đã được cài đặt"
        else
            print_warning "$pkg chưa được cài đặt"
        fi
    done
}

# Show post-installation instructions
show_instructions() {
    print_status "Hướng dẫn sau khi cài đặt:"
    echo
    echo "1. Logout và login lại để GNOME áp dụng đầy đủ cấu hình"
    echo "2. Mở GNOME Tweaks để tùy chỉnh thêm"
    echo "3. Sử dụng Extension Manager để quản lý extensions"
    echo "4. Kiểm tra Settings > About để xác nhận version"
    echo
    echo "Các phím tắt hữu ích:"
    echo "  Super + Return: Mở Terminal"
    echo "  Super + E: Mở File Manager"
    echo "  Super + Q: Đóng cửa sổ"
    echo "  Super + M: Toggle maximize"
    echo "  Super + 1-4: Chuyển workspace"
    echo "  Super + L: Lock screen"
    echo
    echo "Backup cấu hình hiện tại:"
    echo "  gnome-backup: Backup settings hiện tại"
    echo "  gnome-restore: Khôi phục từ backup"
    echo
    print_success "Cài đặt GNOME hoàn tất!"
}

# Main execution
main() {
    echo "=========================================="
    echo "    GNOME Modern Setup for NixOS"
    echo "     Best Practices Configuration"
    echo "=========================================="
    echo
    
    check_nixos
    check_gnome
    
    print_status "Bắt đầu thiết lập GNOME hiện đại..."
    
    # Create backup directory
    mkdir -p ~/backups/{gnome,nixos}
    
    backup_config
    apply_nixos_config
    apply_home_manager
    
    # Only setup extensions if in GNOME session
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        setup_extensions
        optimize_performance
    fi
    
    verify_installation
    show_instructions
}

# Run main function
main "$@" 