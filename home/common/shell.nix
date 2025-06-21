{ config, pkgs, ... }:

{
  # Common Bash configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      cls = "clear";
      ".." = "cd ..";
      "..." = "cd ../..";
      grep = "rg";
      cat = "bat";
      config = "cd /etc/nixos";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
      
      # NeoVim
      vi = "nvim";
      vim = "nvim";
      nv = "nvim";
    };
    
    bashrcExtra = ''
      # Auto-start ssh-agent
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
      fi
      
      # Custom prompt
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';
  };

  # Common SSH configuration
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # SSH agent service
  services.ssh-agent.enable = true;

  # Common direnv (for development)
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Common system utilities
  home.packages = with pkgs; [
    neofetch
    unzip
    zip
    
    # Fonts for icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
} 