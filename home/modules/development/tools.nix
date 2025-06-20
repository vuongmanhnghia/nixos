{ config, pkgs, ... }:

{
  # Development tools and utilities
  home.packages = with pkgs; [
    # Code quality
    shellcheck
  ];
  
  # Tool configurations
  programs = {
    # Better terminal multiplexer config
    tmux = {
      enable = true;
      keyMode = "vi";
      extraConfig = ''
        set -g mouse on
        set -g status-style bg=black,fg=white
      '';
    };
  };
} 