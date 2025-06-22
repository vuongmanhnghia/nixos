{ config, pkgs, ... }:

{
  imports = [ 
    ./default.nix 
    ./gnome-user-config.nix  # Import GNOME user configurations
    ./tmux.nix              # Import tmux configuration
  ];

  # User info
  home.username = "nagih";
  home.homeDirectory = "/home/nagih";
  home.stateVersion = "25.05";

  # User-specific Git config
  programs.git = {
    userName = "Nagih";
    userEmail = "vuongmanhnghia@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };

  # User-specific packages (additional to GNOME packages)
  home.packages = with pkgs; [
    # Personal applications
    google-chrome
    discord
    spotify
    code-cursor
    
    # Gaming
    steam
    steam-run
    protonup-qt    # Proton version management
    winetricks     # Wine/Proton support
    
    # Productivity
    obsidian
    obs-studio
  ];
  
  # Syncthing configuration
  services.syncthing = {
    enable = true;
    
    settings = {
      # GUI configuration
      gui = {
        address = "127.0.0.1:8384";
        user = "nagih";
        # NOTE: Set password via web interface for security
        # Remove hardcoded password from config
      };
      
      devices = {
        # NOTE: Replace with actual device IDs
        "laptop" = { id = "LAPTOP-DEVICE-ID-HERE"; };
        "desktop" = { id = "ABLZ4HZ-4LT6U5O-KLDDQO7-WTCX3KQ-CJBPT73-666IPZJ-UALV3FO-GEG5DQU"; };
      };
      
      # Sync folder configuration
      folders = {
        "Documents" = {
          id = "documents";
          path = "/home/nagih/Documents";
          devices = [ "laptop" "desktop" ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";  # Keep 10 old versions
            };
          };
        };
        
        "Photos" = {
          id = "photos";
          path = "/home/nagih/Pictures/Sync";
          devices = [ "desktop" "laptop" ];
          type = "receiveonly";  # Only receive, don't send
        };

        "Workspaces" = {
          id = "workspaces";
          path = "/home/nagih/Workspaces/workspaces";
          devices = ["desktop" "laptop"];
        };
      };
      
      # Global options
      options = {
        globalAnnounceEnabled = true;
        localAnnounceEnabled = true;
        relaysEnabled = true;
      };
    };
  };
  
  # Create necessary directories
  home.activation.createSyncthingDirs = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/Documents
    mkdir -p $HOME/Pictures/Sync
    mkdir -p $HOME/Workspaces/workspaces
  '';
  
  # Development environment
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # User-specific aliases for development workflow
  programs.bash.shellAliases = {
    workspaces = "cd ~/Workspaces";
    web = "cd ~/Workspaces/Dev/Web";
    app = "cd ~/Workspaces/Dev/App";
    nixconfig = "cd ~/Workspaces/config/nixos";
    
    # GNOME-specific aliases
    gnome-reset = "dconf reset -f /org/gnome/";
    gnome-backup = "dconf dump /org/gnome/ > ~/gnome-settings-backup.txt";
    gnome-restore = "dconf load /org/gnome/ < ~/gnome-settings-backup.txt";
    extensions-list = "gnome-extensions list";
    extensions-prefs = "gnome-extensions prefs";
    
    # Tmux aliases
    tm = "tmux";
    tma = "tmux attach";
    tms = "tmux list-sessions";
    tmk = "tmux kill-session -t";
    tmux-helper = "bash ~/Workspaces/Config/nixos/home/tmux-helper.sh";
    th = "bash ~/Workspaces/Config/nixos/home/tmux-helper.sh";  # Short alias
    
    # VSCode launcher alias
    vscode = "vscode-launcher";
  };
  
  # Add tmux helper script to PATH
  home.file.".local/bin/tmux-helper" = {
    source = ./tmux-helper.sh;
    executable = true;
  };

  # Add vscode-launcher script to fix VSCode issues
  home.file.".local/bin/vscode-launcher" = {
    text = ''
      #!/bin/bash
      # Clear LD_LIBRARY_PATH to avoid conflicts with Cursor libraries
      # Force X11 backend (already set in sessionVariables but ensuring here)
      env \
        LD_LIBRARY_PATH="" \
        ELECTRON_FORCE_IS_PACKAGED="true" \
        ELECTRON_NO_ATTACH_CONSOLE="1" \
        ${pkgs.vscode}/bin/code \
        --no-sandbox \
        --disable-gpu-sandbox \
        --disable-dev-shm-usage \
        "$@"
    '';
    executable = true;
  };

  # Add convenient vscode-open script
  home.file.".local/bin/vscode-open" = {
    text = ''
      #!/bin/bash
      # Convenient script to open VSCode with proper environment
      echo "Opening VSCode..."
      
      # Ensure proper environment
      export NIXOS_OZONE_WL="0"
      export GDK_BACKEND="x11"
      export QT_QPA_PLATFORM="xcb"
      export LD_LIBRARY_PATH=""
      
      # Launch VSCode
      exec ${pkgs.vscode}/bin/code \
        --no-sandbox \
        --disable-gpu-sandbox \
        --disable-dev-shm-usage \
        "$@"
    '';
    executable = true;
  };

  # Environment variables - removed conflicts, kept user-specific only
  home.sessionVariables = {
    # Personal development settings
    EDITOR = "nvim";
    BROWSER = "google-chrome";
    TERMINAL = "gnome-terminal";
    
    # Personal directories
    DOWNLOAD_DIR = "${config.home.homeDirectory}/Downloads";
    DOCUMENTS_DIR = "${config.home.homeDirectory}/Documents";
    
    # Development environment
    NODE_OPTIONS = "--max-old-space-size=8192";
    PNPM_HOME = "${config.home.homeDirectory}/.pnpm";
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    
    # Personal productivity
    OBSIDIAN_USE_WAYLAND = "1";
    ANKI_WAYLAND = "1";
  };
}
