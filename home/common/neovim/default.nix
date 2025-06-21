{ config, pkgs, ... }:

{
  # Cài đặt Neovim với các plugin cần thiết
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    
    # Cài đặt các plugin cơ bản
    plugins = with pkgs.vimPlugins; [
      # Plugin manager
      lazy-nvim
      
      # Colorscheme
      tokyonight-nvim
      catppuccin-nvim
      
      # File explorer
      nvim-tree-lua
      nvim-web-devicons
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      
      # LSP
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      
      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      friendly-snippets
      
      # C++ specific plugins
      # vim-cpp-modern  # Not available in nixpkgs
      # clangd_extensions-nvim  # Not available in nixpkgs
      
      # Debugging
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      
      # Code runner
      # code-runner-nvim  # Not available in nixpkgs
      
      # Better quickfix
      trouble-nvim
      
      # Treesitter
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
        p.tree-sitter-c
        p.tree-sitter-cpp
        p.tree-sitter-cmake
      ]))
      
      # Git integration
      gitsigns-nvim
      vim-fugitive
      
      # Status line
      lualine-nvim
      
      # Indent guides
      indent-blankline-nvim
      
      # Comment
      comment-nvim
      
      # Autopairs
      nvim-autopairs
      
      # Which key
      which-key-nvim
      
      # Terminal
      toggleterm-nvim
      
      # Competitive programming helpers
      # vim-competitive-programming  # Not available in nixpkgs
      
      # Better search/replace
      nvim-spectre
      
      # Markdown preview (for notes)
      markdown-preview-nvim
    ];
    
    # Cấu hình Neovim bằng Lua
    extraLuaConfig = builtins.readFile ./config.lua;
  };
  
  # LSP servers và development tools
  home.packages = with pkgs; [
    # C++ development tools
    clang-tools  # clangd, clang-format, clang-tidy
    lldb         # Debugger
    cmake        # Build system
    ninja        # Build system
    pkg-config   # Library discovery
    
    # LSP servers
    nil # Nix LSP
    lua-language-server
    rust-analyzer
    gopls
    nodePackages.typescript-language-server
    pyright
    
    # Development tools
    tree
    ripgrep
    fd
    bat
    jq
    
    # Formatters
    nixfmt-rfc-style
    stylua
    rustfmt
    go # Bao gồm gofmt
    nodePackages.prettier
    black
    
    # C++ specific tools
    cppcheck     # Static analysis
    valgrind     # Memory debugging
    gdb          # GNU debugger
    
    # Build tools
    gnumake
    gcc
    
    # Competitive programming tools
    hyperfine    # Benchmarking
  ];
} 