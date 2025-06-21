{ config, pkgs, ... }:

{
  # Essential system packages with comprehensive C++ development tools
  environment.systemPackages = with pkgs; [
    # === NETWORK UTILITIES ===
    curl     # Command-line tool for data transfer with URLs
    wget     # Network downloader for retrieving files from web servers
    
    # === REMOTE ACCESS ===
    openssh  # Secure Shell for remote login and command execution
    
    # === SYSTEM MONITORING ===
    htop     # Interactive process viewer and system monitor
    
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