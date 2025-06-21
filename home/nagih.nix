{ config, pkgs, ... }:

{
  # === IMPORT SHARED CONFIGURATION ===
  imports = [ 
    ./default.nix   # Import shared home configuration for all users
  ];

  # === USER INFORMATION ===
  home.username = "nagih";            # Username for this configuration
  home.homeDirectory = "/home/nagih"; # User's home directory path
  home.stateVersion = "25.05";        # Home Manager version (should match NixOS)

  # === USER-SPECIFIC GIT CONFIGURATION ===
  programs.git = {
    userName = "Nagih";                    # Git commit author name
    userEmail = "vuongmanhnghia@gmail.com"; # Git commit author email
  };

  # === USER-SPECIFIC APPLICATIONS ===
  home.packages = with pkgs; [
    # === PERSONAL PRODUCTIVITY APPLICATIONS ===
    firefox        # Firefox web browser
    discord        # Discord chat and communication platform
    spotify        # Spotify music streaming service
    code-cursor    # Cursor AI-powered code editor
    
    # === GAMING APPLICATIONS ===
    steam          # Steam gaming platform
    steam-run      # Steam runtime for non-Steam applications
    protonup-qt    # Proton version management GUI tool
    winetricks     # Wine/Proton dependency management tool
    
    # === PRODUCTIVITY AND CONTENT CREATION ===
    obsidian       # Note-taking and knowledge management application
    zoom-us
    obs-studio     # Open Broadcaster Software for streaming and recording
  ];
  
  # === SYNCTHING FILE SYNCHRONIZATION SERVICE ===
  services.syncthing = {
    enable = true;  # Enable Syncthing file synchronization
    
    settings = {
      # === SYNCTHING WEB GUI CONFIGURATION ===
      gui = {
        address = "127.0.0.1:8384";  # Local web interface address
        user = "nagih";              # GUI username
      };
      
      # === DEVICE CONFIGURATION ===
      # Define other devices for synchronization (replace IDs with actual device IDs)
      devices = {
        "laptop" = { id = "LAPTOP-DEVICE-ID-REPLACE-ME"; };   # Laptop device
        "desktop" = { id = "DESKTOP-DEVICE-ID-REPLACE-ME"; }; # Desktop device
      };
      
      # === FOLDER SYNCHRONIZATION CONFIGURATION ===
      folders = {
        # Synchronize Documents folder across devices
        "Documents" = {
          id = "documents";                     # Unique folder identifier
          path = "/home/nagih/Documents";       # Local folder path
          devices = [ "laptop" "desktop" ];     # Devices to sync with
        };
        
        # Synchronize Workspaces folder for development projects
        "Workspaces" = {
          id = "workspaces";                    # Unique folder identifier
          path = "/home/nagih/Workspaces";      # Local folder path
          devices = ["desktop" "laptop"];       # Devices to sync with
        };
      };
    };
  };
  
  # === DIRECTORY CREATION ===
  # Ensure required directories exist for Syncthing
  home.activation.createSyncDirs = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/Documents   # Create Documents directory if it doesn't exist
    mkdir -p $HOME/Workspaces  # Create Workspaces directory if it doesn't exist
  '';

  # === USER-SPECIFIC ENVIRONMENT VARIABLES ===
  home.sessionVariables = {
    DOWNLOAD_DIR = "${config.home.homeDirectory}/Downloads";  # Downloads directory path
    DOCUMENTS_DIR = "${config.home.homeDirectory}/Documents"; # Documents directory path
  };
}
