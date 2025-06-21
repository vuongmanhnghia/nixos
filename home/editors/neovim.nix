{ config, pkgs, ... }:

{
  # Neovim configuration with essential plugins
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    
    # Essential plugins
    plugins = with pkgs.vimPlugins; [
      # Plugin manager
      lazy-nvim
      
      # Colorschemes
      tokyonight-nvim
      catppuccin-nvim
      
      # File explorer
      nvim-tree-lua
      nvim-web-devicons
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      
      # LSP support
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      
      # Completion engine
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      
      # Syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-javascript
        p.tree-sitter-typescript
        p.tree-sitter-rust
        p.tree-sitter-go
        p.tree-sitter-html
        p.tree-sitter-css
        p.tree-sitter-json
        p.tree-sitter-yaml
        p.tree-sitter-markdown
      ]))
      
      # Git integration
      gitsigns-nvim
      vim-fugitive
      
      # UI enhancements
      lualine-nvim
      indent-blankline-nvim
      which-key-nvim
      
      # Editor utilities
      comment-nvim
      nvim-autopairs
      toggleterm-nvim
    ];
    
    # Neovim configuration in Lua
    extraLuaConfig = ''
      -- Basic editor settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undofile = true
      vim.opt.hlsearch = false
      vim.opt.incsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 50
      vim.opt.colorcolumn = "160"
      
      -- System integration
      vim.opt.clipboard = "unnamedplus"
      vim.opt.mouse = "a"
      
      -- Better search
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      
      -- Completion settings
      vim.opt.completeopt = "menuone,noselect"
      vim.opt.showmatch = true
      
      -- Leader key
      vim.g.mapleader = " "
      
      -- Colorscheme
      vim.cmd([[colorscheme tokyonight-night]])
      
      -- Essential keymaps
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
      vim.keymap.set("n", "J", "mzJ`z")
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")
      
      -- Modern editor keybindings
      -- Word deletion
      vim.keymap.set("i", "<C-BS>", "<C-w>")
      vim.keymap.set("i", "<C-h>", "<C-w>")
      vim.keymap.set("i", "<C-Del>", "<C-o>dw")
      
      -- Page navigation
      vim.keymap.set("n", "<PageUp>", "<C-u>zz")
      vim.keymap.set("n", "<PageDown>", "<C-d>zz")
      vim.keymap.set("i", "<PageUp>", "<C-o><C-u><C-o>zz")
      vim.keymap.set("i", "<PageDown>", "<C-o><C-d><C-o>zz")
      
      -- Line navigation
      vim.keymap.set("n", "<Home>", "^")
      vim.keymap.set("n", "<End>", "$")
      vim.keymap.set("i", "<Home>", "<C-o>^")
      vim.keymap.set("i", "<End>", "<C-o>$")
      vim.keymap.set("v", "<Home>", "^")
      vim.keymap.set("v", "<End>", "$")
      
      -- File navigation
      vim.keymap.set("n", "<C-Home>", "gg")
      vim.keymap.set("n", "<C-End>", "G")
      vim.keymap.set("i", "<C-Home>", "<C-o>gg")
      vim.keymap.set("i", "<C-End>", "<C-o>G")
      
      -- Word navigation
      vim.keymap.set("n", "<C-Left>", "b")
      vim.keymap.set("n", "<C-Right>", "w")
      vim.keymap.set("i", "<C-Left>", "<C-o>b")
      vim.keymap.set("i", "<C-Right>", "<C-o>w")
      vim.keymap.set("v", "<C-Left>", "b")
      vim.keymap.set("v", "<C-Right>", "w")
      
      -- Text selection
      vim.keymap.set("n", "<S-Left>", "vh")
      vim.keymap.set("n", "<S-Right>", "vl")
      vim.keymap.set("n", "<S-Up>", "vk")
      vim.keymap.set("n", "<S-Down>", "vj")
      vim.keymap.set("v", "<S-Left>", "h")
      vim.keymap.set("v", "<S-Right>", "l")
      vim.keymap.set("v", "<S-Up>", "k")
      vim.keymap.set("v", "<S-Down>", "j")
      
      -- Word selection
      vim.keymap.set("n", "<C-S-Left>", "vb")
      vim.keymap.set("n", "<C-S-Right>", "vw")
      vim.keymap.set("v", "<C-S-Left>", "b")
      vim.keymap.set("v", "<C-S-Right>", "w")
      
      -- Standard shortcuts
      vim.keymap.set("n", "<C-a>", "ggVG")
      vim.keymap.set("i", "<C-a>", "<C-o>ggVG")
      vim.keymap.set("v", "<C-c>", '"+y')
      vim.keymap.set("n", "<C-v>", '"+p')
      vim.keymap.set("i", "<C-v>", '<C-o>"+p')
      vim.keymap.set("v", "<C-x>", '"+d')
      vim.keymap.set("n", "<C-s>", ":w<CR>")
      vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")
      
      -- Window management
      vim.keymap.set("n", "<C-w>", ":q<CR>")
      vim.keymap.set("i", "<C-w>", "<Esc>:q<CR>")
      
      -- Tab management
      vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
      vim.keymap.set("i", "<C-t>", "<Esc>:tabnew<CR>")
      vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>")
      vim.keymap.set("n", "<C-S-Tab>", ":tabprev<CR>")
      
      -- Line operations
      vim.keymap.set("n", "<C-l>", "V")
      vim.keymap.set("i", "<C-l>", "<Esc>V")
      vim.keymap.set("n", "<C-d>", "Vyp")
      vim.keymap.set("i", "<C-d>", "<Esc>Vyp")
      
      -- Find and replace
      vim.keymap.set("n", "<C-f>", "/")
      vim.keymap.set("i", "<C-f>", "<Esc>/")
      vim.keymap.set("n", "<C-h>", ":%s/")
      vim.keymap.set("i", "<C-h>", "<Esc>:%s/")
      
      -- Undo/Redo
      vim.keymap.set("n", "<C-z>", "u")
      vim.keymap.set("i", "<C-z>", "<C-o>u")
      vim.keymap.set("n", "<C-y>", "<C-r>")
      vim.keymap.set("i", "<C-y>", "<C-o><C-r>")
    '';
  };
} 