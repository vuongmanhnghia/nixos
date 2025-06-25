{ config, pkgs, ... }:

{
  # Essential system packages with comprehensive C++ development tools
  environment.systemPackages = with pkgs; [
    # === NETWORK UTILITIES ===
    curl     # Command-line tool for data transfer with URLs
    wget     # Network downloader for retrieving files from web servers
    
    # === VERSION CONTROL ===
    git      # Distributed version control system
    
    # === REMOTE ACCESS ===
    openssh  # Secure Shell for remote login and command execution
    
    # === SYSTEM MONITORING ===
    htop     # Interactive process viewer and system monitor
    
    # === C++ DEVELOPMENT ECOSYSTEM ===
    
    # Core compilers and build systems
    gcc         # GNU Compiler Collection for C/C++
    clang       # LLVM-based C/C++ compiler with better diagnostics
    cmake       # Cross-platform build system generator
    gnumake     # GNU make build automation tool
    ninja       # Fast build system focused on speed
    pkg-config  # Helper tool for compiling applications and libraries
    
    # Language Server Protocol and development tools
    clang-tools  # Includes clangd (LSP), clang-format, clang-tidy for code analysis
    
    # Debugging and analysis tools
    gdb         # GNU Debugger for debugging programs
    lldb        # LLVM debugger with modern interface
    valgrind    # Memory error detector and profiler
    
    # Additional build system tools
    meson       # Modern build system with Python-based configuration
    automake    # Automatic Makefile generator
    autoconf    # Automatic configure script generator
    libtool     # Generic library support script
    
    # Essential libraries and headers
    stdenv.cc.cc.lib  # Standard C library and compiler runtime
    glibc.dev         # GNU C Library development headers
    
    # Code quality and static analysis
    cppcheck    # Static analysis tool for C/C++ code
    
    # Documentation generation
    doxygen     # Documentation generator for multiple programming languages
    
    # Performance profiling and optimization
    linuxPackages.perf  # Linux performance analysis tools
    
    # Binary utilities and system tools
    binutils  # Collection of binary tools (objdump, nm, strip, etc.)
    file      # File type identification utility
    which     # Locate command binary in PATH
    tree      # Display directory structure in tree format
  ];
  
  # Allow installation of proprietary software (required for some development tools)
  nixpkgs.config.allowUnfree = true;
} 