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
      core.pager = "delta";
      
      # === DELTA CONFIGURATION ===
      interactive.diffFilter = "delta --color-only";
      
      delta = {
        features = "side-by-side line-numbers decorations";
        syntax-theme = "TwoDark";
        plus-style = "syntax #012800";
        minus-style = "syntax #340001";
        line-numbers = true;
        decorations = true;
      };
      
      "delta \"decorations\"" = {
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow ul";
        file-decoration-style = "none";
        hunk-header-decoration-style = "cyan box ul";
      };
      
      "delta \"line-numbers\"" = {
        line-numbers-left-style = "cyan";
        line-numbers-right-style = "cyan";
        line-numbers-minus-style = "124";
        line-numbers-plus-style = "28";
      };
      
      diff = {
        colorMoved = "default";
        tool = "delta";
      };
      
      merge.conflictstyle = "diff3";
    };
  };
} 