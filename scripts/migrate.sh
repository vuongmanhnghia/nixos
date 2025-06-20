#!/usr/bin/env bash

# Migration script from old configuration to new professional structure
# Run this script to migrate from your current setup

set -e

echo "🚀 NixOS Configuration Migration Script"
echo "======================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_step() {
    echo -e "${BLUE}▶${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Backup existing configuration
backup_config() {
    print_step "Creating backup of existing configuration..."
    
    if [ -f "configuration.nix" ]; then
        cp configuration.nix configuration.nix.backup
        print_success "Backed up configuration.nix"
    fi
    
    if [ -d "home" ]; then
        cp -r home home.backup
        print_success "Backed up home directory"
    fi
    
    if [ -d "modules" ]; then
        cp -r modules modules.backup
        print_success "Backed up modules directory"
    fi
}

# Move files to new structure
migrate_files() {
    print_step "Migrating files to new structure..."
    
    # Move old system modules to new location (if they exist in old structure)
    if [ -f "modules/system/boot.nix" ]; then
        print_success "System modules already in correct location"
    fi
    
    # Move home configuration
    if [ -f "home/nagih.nix" ]; then
        mkdir -p home/users/nagih
        if [ ! -f "home/users/nagih/default.nix" ]; then
            print_warning "Moving home/nagih.nix content to new structure"
            echo "# This is migrated content from nagih.nix" > home/users/nagih/migrated.nix
            echo "# Please integrate this with the new home/users/nagih/default.nix" >> home/users/nagih/migrated.nix
            cat home/nagih.nix >> home/users/nagih/migrated.nix
        fi
    fi
    
    # Create missing directories
    mkdir -p {overlays,lib,secrets}
    print_success "Created additional directories"
}

# Install required packages
install_packages() {
    print_step "Installing required packages..."
    
    # Check if alejandra is available for formatting
    if ! command -v alejandra &> /dev/null; then
        print_warning "alejandra not found. Install with: nix profile install nixpkgs#alejandra"
    fi
    
    # Check if sops is available for secrets management
    if ! command -v sops &> /dev/null; then
        print_warning "sops not found. Install with: nix profile install nixpkgs#sops"
    fi
}

# Update flake.lock
update_flake() {
    print_step "Updating flake inputs..."
    
    if [ -f "flake.nix" ]; then
        nix flake update
        print_success "Updated flake.lock"
    else
        print_error "flake.nix not found!"
        exit 1
    fi
}

# Validate configuration
validate_config() {
    print_step "Validating new configuration..."
    
    if nix flake check; then
        print_success "Configuration validation passed"
    else
        print_error "Configuration validation failed"
        print_warning "Check the errors above and fix them before proceeding"
        return 1
    fi
}

# Main migration process
main() {
    echo
    print_step "Starting migration process..."
    echo
    
    # Ask for confirmation
    echo -e "${YELLOW}This will modify your current NixOS configuration.${NC}"
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Migration cancelled by user"
        exit 0
    fi
    
    # Perform migration steps
    backup_config
    echo
    
    migrate_files
    echo
    
    install_packages
    echo
    
    update_flake
    echo
    
    if validate_config; then
        echo
        print_success "Migration completed successfully!"
        echo
        echo -e "${GREEN}Next steps:${NC}"
        echo "1. Review the new configuration files"
        echo "2. Customize settings in hosts/desktop/configuration.nix"
        echo "3. Update home/users/nagih/default.nix with your preferences"
        echo "4. Run 'make check' to validate"
        echo "5. Run 'make switch' to apply the new configuration"
        echo
        echo -e "${BLUE}Available commands:${NC}"
        echo "  make help    - Show all available commands"
        echo "  make check   - Validate configuration"
        echo "  make switch  - Apply configuration"
        echo "  make update  - Update flake inputs"
        echo
    else
        print_error "Migration completed with errors"
        echo "Please fix the configuration issues before switching"
    fi
}

# Run the migration
main "$@" 