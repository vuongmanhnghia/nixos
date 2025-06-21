{ config, pkgs, ... }:

{
  # Common Git configuration
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };

  # Git-related packages
  home.packages = with pkgs; [
    git-lfs
    gh
  ];
} 