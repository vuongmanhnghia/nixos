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
    ];
    
    # Cấu hình Neovim bằng Lua
    extraLuaConfig = ''
      -- Basic settings
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
      vim.opt.isfname:append("@-@")
      vim.opt.updatetime = 50
      vim.opt.colorcolumn = "160"
      
      -- Enable system clipboard
      vim.opt.clipboard = "unnamedplus"
      
      -- Mouse support
      vim.opt.mouse = "a"
      
      -- Better search
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      
      -- Better completion
      vim.opt.completeopt = "menuone,noselect"
      
      -- Show matching brackets
      vim.opt.showmatch = true
      
      -- Set leader key
      vim.g.mapleader = " "
      
      -- Colorscheme
      vim.cmd([[colorscheme tokyonight-night]])
      
      -- Basic keymaps
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
      vim.keymap.set("n", "J", "mzJ`z")
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")
      
      -- Modern editor keybindings
      -- Ctrl+Backspace: Xóa từ phía trước cursor
      vim.keymap.set("i", "<C-BS>", "<C-w>")
      vim.keymap.set("i", "<C-h>", "<C-w>") -- Alternative cho các terminal không hỗ trợ C-BS
      
      -- Ctrl+Delete: Xóa từ phía sau cursor  
      vim.keymap.set("i", "<C-Del>", "<C-o>dw")
      
      -- Page Up/Down với centering
      vim.keymap.set("n", "<PageUp>", "<C-u>zz")
      vim.keymap.set("n", "<PageDown>", "<C-d>zz")
      vim.keymap.set("i", "<PageUp>", "<C-o><C-u><C-o>zz")
      vim.keymap.set("i", "<PageDown>", "<C-o><C-d><C-o>zz")
      
      -- Home/End keys
      vim.keymap.set("n", "<Home>", "^") -- Đầu dòng (bỏ qua whitespace)
      vim.keymap.set("n", "<End>", "$") -- Cuối dòng
      vim.keymap.set("i", "<Home>", "<C-o>^")
      vim.keymap.set("i", "<End>", "<C-o>$")
      vim.keymap.set("v", "<Home>", "^")
      vim.keymap.set("v", "<End>", "$")
      
      -- Ctrl+Home/End: Đầu/cuối file
      vim.keymap.set("n", "<C-Home>", "gg")
      vim.keymap.set("n", "<C-End>", "G")
      vim.keymap.set("i", "<C-Home>", "<C-o>gg")
      vim.keymap.set("i", "<C-End>", "<C-o>G")
      
      -- Ctrl+Left/Right: Di chuyển theo từ
      vim.keymap.set("n", "<C-Left>", "b")
      vim.keymap.set("n", "<C-Right>", "w")
      vim.keymap.set("i", "<C-Left>", "<C-o>b")
      vim.keymap.set("i", "<C-Right>", "<C-o>w")
      vim.keymap.set("v", "<C-Left>", "b")
      vim.keymap.set("v", "<C-Right>", "w")
      
      -- Shift+Arrow: Selection
      vim.keymap.set("n", "<S-Left>", "vh")
      vim.keymap.set("n", "<S-Right>", "vl")
      vim.keymap.set("n", "<S-Up>", "vk")
      vim.keymap.set("n", "<S-Down>", "vj")
      vim.keymap.set("v", "<S-Left>", "h")
      vim.keymap.set("v", "<S-Right>", "l")
      vim.keymap.set("v", "<S-Up>", "k")
      vim.keymap.set("v", "<S-Down>", "j")
      
      -- Ctrl+Shift+Left/Right: Select theo từ
      vim.keymap.set("n", "<C-S-Left>", "vb")
      vim.keymap.set("n", "<C-S-Right>", "vw")
      vim.keymap.set("v", "<C-S-Left>", "b")
      vim.keymap.set("v", "<C-S-Right>", "w")
      
      -- Ctrl+A: Select all
      vim.keymap.set("n", "<C-a>", "ggVG")
      vim.keymap.set("i", "<C-a>", "<C-o>ggVG")
      
      -- Ctrl+C/V/X: Copy/Paste/Cut (system clipboard)
      vim.keymap.set("v", "<C-c>", '"+y')
      vim.keymap.set("n", "<C-v>", '"+p')
      vim.keymap.set("i", "<C-v>", '<C-o>"+p')
      vim.keymap.set("v", "<C-x>", '"+d')
      
      -- Ctrl+S: Save
      vim.keymap.set("n", "<C-s>", ":w<CR>")
      vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>")
      
      -- Ctrl+Z: Undo
      vim.keymap.set("n", "<C-z>", "u")
      vim.keymap.set("i", "<C-z>", "<C-o>u")
      
      -- Ctrl+Y: Redo
      vim.keymap.set("n", "<C-y>", "<C-r>")
      vim.keymap.set("i", "<C-y>", "<C-o><C-r>")
      
      -- Tab/Shift+Tab: Indent/Unindent
      vim.keymap.set("v", "<Tab>", ">gv")
      vim.keymap.set("v", "<S-Tab>", "<gv")
      vim.keymap.set("n", "<Tab>", ">>")
      vim.keymap.set("n", "<S-Tab>", "<<")
      
      -- Ctrl+/: Comment toggle (sẽ hoạt động với Comment plugin)
      vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
      vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")
      
      -- F3: Tìm next
      vim.keymap.set("n", "<F3>", "n")
      
      -- Escape alternatives
      vim.keymap.set("i", "jk", "<Esc>")
      vim.keymap.set("i", "kj", "<Esc>")
      
      -- Window navigation
      vim.keymap.set("n", "<C-h>", "<C-w>h")
      vim.keymap.set("n", "<C-j>", "<C-w>j")
      vim.keymap.set("n", "<C-k>", "<C-w>k")
      vim.keymap.set("n", "<C-l>", "<C-w>l")
      
      -- Resize windows
      vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
      vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
      vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
      vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
      
      -- Telescope
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      
      -- Nvim-tree
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
      
      -- Configure plugins
      require('nvim-tree').setup{}
      require('lualine').setup{}
      require('gitsigns').setup{}
      require('Comment').setup{}
      require('nvim-autopairs').setup{}
      require('which-key').setup{}
      
      -- LSP setup
      local lsp = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Configure LSP servers
      lsp.nil_ls.setup{
        capabilities = capabilities,
      }
      
      lsp.lua_ls.setup{
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            }
          }
        }
      }
      
      -- Completion setup
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
      
      -- Treesitter setup
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        }
      }
    '';
  };
  
  # Common packages - only essential tools
  home.packages = with pkgs; [
    # LSP servers (development tools)
    nil # Nix LSP
    lua-language-server
    rust-analyzer
    gopls
    nodePackages.typescript-language-server
    pyright
    
    # Formatters
    nixfmt-rfc-style
    stylua
    rustfmt
    go # Bao gồm gofmt
    nodePackages.prettier
    black
    
    # Essential Git tools
    git-lfs
    
    # System utilities (minimal set)
    neofetch
  ];
  
  # Common Git configuration - consolidated
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      pull.rebase = false;
      core.editor = "nvim";
      
      # Better diff handling
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
    };
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
      
      #NeoVim
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
  
  home-manager.backupFileExtension = "backup";

  # Common programs
  programs.home-manager.enable = true;
  
  # Common direnv (for development)
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
