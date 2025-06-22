{ config, pkgs, ... }:

{
  imports = [ 
    ./default.nix 
    ./gnome-user-config.nix  # Import GNOME user configurations
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
    # Development
    docker-compose
   
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
  };
}
