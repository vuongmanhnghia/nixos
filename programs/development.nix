{ config, pkgs, ... }:

{
  # === CONTAINERIZATION PLATFORM ===
  virtualisation.docker = {
    enable = true;        # Enable Docker containerization platform
    # Automatic cleanup to prevent disk space issues
    autoPrune = {
      enable = true;      # Enable automatic cleanup of unused Docker resources
      dates = "weekly";   # Run cleanup weekly
    };
  };

  # === VERSION CONTROL SYSTEM ===
  programs.git = {
    enable = true;        # Enable Git system-wide
    config = {
      init.defaultBranch = "main";  # Use 'main' as default branch name (modern standard)
      pull.rebase = false;          # Use merge strategy for git pull (safer default)
    };
  };

  # === DEVELOPMENT TOOLS AND UTILITIES ===
  environment.systemPackages = with pkgs; [
    # === VERSION CONTROL ===
    git      # Distributed version control system
    git-lfs  # Git Large File Storage for handling large binary files
    
    # === CODE EDITORS AND IDEs ===
    neovim   # Modern Vim-based text editor with LSP support
    
    # === TERMINAL MULTIPLEXER AND UTILITIES ===
    tmux     # Terminal multiplexer for managing multiple terminal sessions
    curl     # Command-line tool for data transfer with URLs
    wget     # Network downloader for retrieving files from servers
    tree     # Display directory structures in tree format
    htop     # Interactive process viewer and system monitor
    
    # === MODERN CLI REPLACEMENTS ===
    ripgrep  # Fast text search tool (better grep replacement)
    fd       # Fast and user-friendly alternative to find
    bat      # Syntax-highlighted cat replacement
    eza      # Modern ls replacement with better formatting
    
    # === SYNTAX HIGHLIGHTING AND CODE TOOLS ===
    highlight         # Universal syntax highlighter
    glow             # Markdown renderer for terminal
    delta            # Better git diff with syntax highlighting
    zsh-syntax-highlighting  # Syntax highlighting for zsh commands
    
    # === COMMAND LINE ENHANCEMENTS ===
    bash-completion   # Enhanced bash completion
    nix-bash-completions  # Nix-specific bash completions
    bash-preexec     # Preexec hooks for bash
    nix-index        # Fast file and package search for Nix
    comma            # Command-not-found handler for Nix
    blesh            # Bash Line Editor with syntax highlighting
    
    # === ADDITIONAL CLI TOOLS ===
    thefuck          # Command correction tool
    mcfly            # Neural command history search
    
    # === ARCHIVE AND COMPRESSION TOOLS ===
    unzip    # Extract ZIP archives
    p7zip    # 7-Zip archive format support
    
    # === NETWORK ANALYSIS TOOLS ===
    nmap     # Network discovery and security auditing tool
    
    # === BUILD SYSTEMS AND COMPILERS ===
    gnumake  # GNU Make build automation tool
    gcc      # GNU Compiler Collection for C/C++
    
    # === PROGRAMMING LANGUAGE RUNTIMES ===
    nodejs   # Node.js JavaScript runtime for web development
    python3  # Python 3 interpreter for scripting and development
    
    # === C++ DEVELOPMENT ECOSYSTEM ===
    # Core compilers and build systems
    gcc         # GNU Compiler Collection for C/C++
    clang       # LLVM-based C/C++ compiler with better diagnostics
    cmake       # Cross-platform build system generator
    gnumake     # GNU make build automation tool
    ninja       # Fast build system focused on speed
    pkg-config  # Helper tool for compiling applications and libraries
    
    # Language Server Protocol and development tools
    gdb
    clang-tools  # Includes clangd (LSP), clang-format, clang-tidy for code analysis
    
    # === SYSTEM INFORMATION TOOLS ===
    neofetch  # System information display tool
    lshw      # List hardware information
    pciutils  # PCI bus utilities (lspci)
    usbutils  # USB utilities (lsusb)
  ];

  # === USER PERMISSIONS ===
  users.users.nagih.extraGroups = [ "docker" ];  # Add user to docker group for container management
} 