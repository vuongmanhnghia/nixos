{ config, pkgs, ... }:

{
  # Development tools and services
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Development packages
  environment.systemPackages = with pkgs; [
    # Version control
    git
    gitui
    gh # GitHub CLI
    
    # Editors
    vim
    nano
    
    # Build tools
    gnumake
    cmake
    ninja
    
    # Compilers
    gcc
    clang
    
    # Debuggers
    gdb
    lldb
    
    # Analysis tools
    valgrind
    cppcheck
    
    # Performance tools
    hyperfine
    perf-tools
    
    # Network tools
    curl
    wget
    
    # System tools
    htop
    btop
    iotop
    
    # File tools
    tree
    fd
    ripgrep
    bat
    
    # Archive tools
    unzip
    p7zip
    
    # JSON/YAML tools
    jq
    yq
  ];

  # Development environment variables
  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "gnome-terminal";
  };

  # Shell aliases for development
  environment.shellAliases = {
    # Git shortcuts
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gl = "git log --oneline";
    
    # Simple audio test
    audio-test = "/home/nagih/Workspaces/Dev/nixos/test-audio-simple.sh";
    
    # Common shortcuts
    ll = "ls -la";
    la = "ls -la";
    l = "ls -l";
    grep = "rg";
    cat = "bat";
    find = "fd";
    
    # System shortcuts
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
    rebuild-test = "sudo nixos-rebuild test --flake /etc/nixos";
    flake-check = "nix flake check /etc/nixos";
  };

  # Programs configuration
  programs = {
    # Bash configuration
    bash = {
      completion.enable = true;
      enableLsColors = true;
    };
    
    # Git global configuration
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
    
    # Neovim system-wide
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
  };
} 