{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.catppuccin
    ];
    enable = true;
    extraConfig = builtins.readFile ../../dotfiles/tmux/tmux.conf;
  };
}
