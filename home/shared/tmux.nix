{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Use the existing tmux.conf file
    extraConfig = builtins.readFile ../../dotfiles/tmux/tmux.conf;
    
    # Enable plugins that are referenced in the config
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
  };

  # Copy the random_note script to the config directory
  home.file.".config/tmux/random_note.sh" = {
    source = ../../dotfiles/tmux/random_note.sh;
    executable = true;
  };
}
