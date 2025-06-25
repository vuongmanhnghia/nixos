{ config, pkgs, ... }:

{
  # === GLOBAL GIT CONFIGURATION ===
  programs.git = {
    enable = true;  # Enable Git version control system
    
    # === GIT BEHAVIOR SETTINGS ===
    extraConfig = {
      init.defaultBranch = "main";  # Use 'main' as default branch name (modern standard)
      push.default = "simple";      # Push only current branch to upstream
      pull.rebase = false;          # Use merge strategy for pulls (safer than rebase)
      core.editor = "nvim";         # Set Neovim as default Git editor
    };
  };
} 