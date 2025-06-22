{ config, pkgs, ... }:

{
  # Essential system packages with C++ development tools
  environment.systemPackages = with pkgs; [
    # Network tools
    curl
    wget
    
    # Version control
    git
    
    # Remote access
    openssh
    
    # System monitoring
    htop
    
    # C++ Development Tools
    # Compiler and build tools
    gcc
    clang
    cmake
    gnumake
    ninja
    pkg-config
    
    # LSP and language servers
    clang-tools  # includes clangd, clang-format, clang-tidy
    
    # Debugging tools
    gdb
    lldb
    valgrind
    
    # Build system tools
    meson
    automake
    autoconf
    libtool
    
    # Libraries and headers (commonly needed)
    stdenv.cc.cc.lib
    glibc.dev
    
    # Static analysis tools
    cppcheck
    
    # Documentation tools
    doxygen
    
    # Performance profiling
    linuxPackages.perf
    
    # Additional utilities for C++ development
    binutils  # objdump, nm, etc.
    file      # file type detection
    which     # command location
    tree      # directory tree display
  ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
} 