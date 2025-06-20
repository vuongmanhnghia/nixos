{ config, pkgs, extensions, ... }:

{  
  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # Essential
      lazy-nvim
      tokyonight-nvim
      nvim-tree-lua
      telescope-nvim
      nvim-lspconfig
      nvim-cmp
      
      # Treesitter
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-javascript
        p.tree-sitter-typescript
      ]))
    ];
    
    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.clipboard = "unnamedplus"
      vim.g.mapleader = " "
      
      -- Colorscheme
      vim.cmd([[colorscheme tokyonight-night]])
    '';
  };
} 