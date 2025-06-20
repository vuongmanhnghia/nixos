{ config, pkgs, inputs, extensions, ... }:

{
  imports = [
    ../../modules/development
    ../../modules/desktop
    ../../modules/media
    ../../profiles/gaming.nix
    ../../profiles/productivity.nix
  ];

  # Basic user info
  home.username = "nagih";
  home.homeDirectory = "/home/nagih";
  home.stateVersion = "25.05";

  # User-specific Git config - consolidated and comprehensive
  programs.git = {
    enable = true;
    userName = "Nagih";
    userEmail = "vuongmanhnghia@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "code";
      
      # Better diff and merge tools
      diff.tool = "vscode";
      merge.tool = "vscode";
      difftool.vscode.cmd = "code --wait --diff $LOCAL $REMOTE";
      mergetool.vscode.cmd = "code --wait $MERGED";
      
      # Enhanced diff and merge settings
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      push.default = "simple";
    };
    
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
      graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };

  # Better shell configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "ll" = "ls -la";
      "la" = "ls -la";
      "l" = "ls -l";
      
      # Development
      "dev" = "cd ~/Workspaces/Dev";
      "web" = "cd ~/Workspaces/Dev/Web";
      "app" = "cd ~/Workspaces/Dev/App";
      
      # NixOS
      "nix-rebuild" = "sudo nixos-rebuild switch --flake .#desktop";
      "nix-update" = "nix flake update";
      "nix-clean" = "sudo nix-collect-garbage -d";
      
      # System
      "grep" = "grep --color=auto";
      "mkdir" = "mkdir -pv";
      "wget" = "wget -c";
      
      # Git shortcuts
      "gs" = "git status";
      "ga" = "git add";
      "gc" = "git commit";
      "gp" = "git push";
      "gl" = "git pull";
      "gd" = "git diff";
    };
    
    bashrcExtra = ''
      # Better history
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoredups:erasedups
      shopt -s histappend
      
      # Better prompt
      export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      
      # Environment variables
      export EDITOR="code"
      export BROWSER="google-chrome"
      export TERMINAL="gnome-terminal"
    '';
  };

  # Directory structure
  home.activation.createDirectories = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/{Workspaces/{Dev/{Web,App,Scripts},Personal},Documents/{Projects,Notes},Downloads/{Software,Media,Documents}}
    mkdir -p $HOME/.local/{bin,share}
  '';

  # XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME/Templates";
      publicShare = "$HOME/Public";
    };
  };

  # User-specific packages - only unique ones not covered by modules
  home.packages = with pkgs; [
    # Web browsers
    google-chrome

    # Development
    code-cursor
    
    # Personal productivity
    obsidian
    
    # System utilities
    htop
    tree
    file
  ];

  # Services
  services = {
    # Syncthing for file sync
    syncthing.enable = true;
    
    # GPG agent
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
} 