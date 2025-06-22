{ config, pkgs, ... }:

{
  # Neovim configuration with essential plugins optimized for C++ development
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
      
      # C++ specific LSP enhancements
      clangd_extensions-nvim
      
      # Completion engine
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      
      # Debugging support
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      
      # CMake integration
      cmake-tools-nvim
      
      # Code formatting
      null-ls-nvim
      
      # Syntax highlighting with C++ support
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
        # C++ support
        p.tree-sitter-c
        p.tree-sitter-cpp
        p.tree-sitter-cmake
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
      -- Basic editor settings (optimized for C++)
      vim.opt.number = true
      vim.opt.relativenumber = true
      -- C++ convention: 4 spaces
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
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
      -- C++ line length convention
      vim.opt.colorcolumn = "120"
      
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
      
      -- LSP Configuration for C++
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Clangd setup with optimized settings
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
      
      -- Clangd extensions setup
      require("clangd_extensions").setup({
        server = {
          -- Options passed to nvim-lspconfig
          -- i.e. the arguments to require("lspconfig").clangd.setup({})
        },
        extensions = {
          -- defaults:
          -- Automatically set inlay hints (type hints)
          autoSetHints = true,
          -- These apply to the default ClangdSetInlayHints command
          inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
            -- Options other than `highlight' and `priority' only work
            -- if `inline' is disabled
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
          },
          ast = {
            role_icons = {
              type = "",
              declaration = "",
              expression = "",
              specifier = "",
              statement = "",
              ["template argument"] = "",
            },
            kind_icons = {
              Compound = "",
              Recovery = "",
              TranslationUnit = "",
              PackExpansion = "",
              TemplateTypeParm = "",
              TemplateTemplateParm = "",
              TemplateParamObject = "",
            },
          },
        },
      })
      
      -- Debugging setup
      local dap = require('dap')
      local dapui = require('dapui')
      
      -- GDB adapter for C++
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }
      
      -- C++ debugging configuration
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "''${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }
      
      -- Same configuration for C
      dap.configurations.c = dap.configurations.cpp
      
      -- DAP UI setup
      dapui.setup()
      
      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Virtual text for debugging
      require("nvim-dap-virtual-text").setup()
      
      -- CMake Tools setup
      require("cmake-tools").setup({
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_build_directory_prefix = "cmake_build_", -- when cmake_build_directory is set to "", this option will be activated
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_console_size = 10, -- cmake output window height
        cmake_show_console = "always", -- "always", "only_on_error"
        cmake_dap_configuration = { -- debug settings for cmake
          name = "cpp",
          type = "gdb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
        cmake_dap_open_command = require("dap").repl.open, -- optional
      })
      
      -- Null-ls setup for formatting
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- C++ formatting with clang-format
          null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style=file" }, -- Use .clang-format file if available
          }),
        },
        -- Format on save
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
      
      -- Treesitter configuration
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
      
      -- CMP setup
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Essential keymaps
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
      vim.keymap.set("n", "J", "mzJ`z")
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")
      
      -- LSP keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })
      
      -- Debugging keymaps
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = "Debug: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
      
      -- CMake keymaps
      vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<CR>", { desc = "CMake: Generate" })
      vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>", { desc = "CMake: Build" })
      vim.keymap.set("n", "<leader>cr", ":CMakeRun<CR>", { desc = "CMake: Run" })
      vim.keymap.set("n", "<leader>cd", ":CMakeDebug<CR>", { desc = "CMake: Debug" })
      vim.keymap.set("n", "<leader>cc", ":CMakeClean<CR>", { desc = "CMake: Clean" })
      
      -- Telescope keymaps
      vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags, { desc = "Help tags" })
      
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
      -- Note: Changed <C-d> mapping to avoid conflict with scroll
      vim.keymap.set("n", "<leader>d", "Vyp")
      vim.keymap.set("i", "<leader>d", "<Esc>Vyp")
      
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