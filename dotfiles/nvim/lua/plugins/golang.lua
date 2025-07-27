return {
  -- Go development plugin
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- Temporarily override vim.notify to suppress go.nvim warnings
      local original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        -- Suppress go.nvim LSP-related warnings
        if type(msg) == "string" and (
          msg:match("lsp_cfg is false") or 
          msg:match("lsp_on_attach ignored") or
          msg:match("max_line_len only effective when gofmt is golines")
        ) then
          return
        end
        return original_notify(msg, level, opts)
      end
      
      require("go").setup({
        -- Go debugging configuration
        goimports = "goimports",     -- goimports command
        gofmt = "gofumpt",          -- use gofumpt instead of gofmt
        max_line_len = 120,         -- max line length in format
        tag_transform = false,      -- transform struct tag
        tag_options = "json=omitempty",
        gotests_template = "",      -- gotests template
        gotests_template_dir = "",  -- gotests template directory
        comment_placeholder = '',   -- comment_placeholder your cool placeholder

        verbose = false,           -- disable verbose output including lsp_cfg warnings
        
        -- LSP configuration
        lsp_cfg = false,           -- false: do nothing, true: apply non-default gopls setup
        lsp_gofumpt = true,        -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = true,      -- use on_attach function from go.nvim
        dap_debug = true,          -- set to false to disable dap debug
        dap_debug_keymap = true,   -- true: use keymap for debugger defined in go/dap.lua
        dap_debug_gui = {},        -- bool|table put your dap-ui setup here
        dap_debug_vt = true,       -- bool put your dap-virtual-text setup here
        
        -- Build configuration
        build_tags = "tag1,tag2",  -- set default build tags
        textobjects = true,        -- enable default textobjects (if you want to disable it, set it to false)
        test_runner = "go",        -- richgo, go test, richgo, dlv, ginkgo
        verbose_tests = true,      -- set to add verbose flag to tests
        run_in_floaterm = false,   -- set to true to run in float window.
        
        -- Code generation
        trouble = true,            -- true: use trouble to open quickfix
        test_efm = false,          -- errorformat for quickfix, default mix mode, set to true will be efm only
        luasnip = true,            -- enable included luasnip snippets. By default snippets are excluded
        
        -- Icons and UI
        icons = {
          breakpoint = '🔴',
          currentpos = '🔶',
        },
        
        -- Auto commands
        auto_format = true,        -- auto format on save
        auto_lint = true,         -- auto lint on save
      })
      
      -- Restore original vim.notify after setup
      vim.notify = original_notify
      
      -- Go specific keymaps
      local function map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then
          options = vim.tbl_extend("force", options, opts)
        end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
      end
      
      -- Go development shortcuts
      map("n", "<leader>ga", ":GoAddTest<CR>", { desc = "Add Go test" })
      map("n", "<leader>gA", ":GoAddExpTest<CR>", { desc = "Add Go exported test" })
      map("n", "<leader>gb", ":GoBuild<CR>", { desc = "Go build" })
      map("n", "<leader>gc", ":GoCoverage<CR>", { desc = "Go coverage" })
      map("n", "<leader>gd", ":GoDoc<CR>", { desc = "Go documentation" })
      map("n", "<leader>ge", ":GoIfErr<CR>", { desc = "Add if err != nil" })
      map("n", "<leader>gf", ":GoFmt<CR>", { desc = "Go format" })
      map("n", "<leader>gi", ":GoImport<CR>", { desc = "Go imports" })
      map("n", "<leader>gl", ":GoLint<CR>", { desc = "Go lint" })
      map("n", "<leader>gm", ":GoMod<CR>", { desc = "Go mod tidy" })
      map("n", "<leader>gr", ":GoRun<CR>", { desc = "Go run" })
      map("n", "<leader>gs", ":GoFillStruct<CR>", { desc = "Fill Go struct" })
      map("n", "<leader>gt", ":GoTest<CR>", { desc = "Go test" })
      map("n", "<leader>gT", ":GoTestFunc<CR>", { desc = "Go test function" })
      map("n", "<leader>gv", ":GoVet<CR>", { desc = "Go vet" })
      map("n", "<leader>gx", ":GoReferrers<CR>", { desc = "Go referrers" })
      
      -- Go debugging shortcuts
      map("n", "<leader>db", ":GoDebug<CR>", { desc = "Start Go debugging" })
      map("n", "<leader>dB", ":GoDebug -t<CR>", { desc = "Debug Go test" })
      map("n", "<leader>dc", ":GoDbgContinue<CR>", { desc = "Continue debugging" })
      map("n", "<leader>dn", ":GoDbgNext<CR>", { desc = "Debug next" })
      map("n", "<leader>ds", ":GoDbgStep<CR>", { desc = "Debug step" })
      map("n", "<leader>do", ":GoDbgStepOut<CR>", { desc = "Debug step out" })
      map("n", "<leader>dq", ":GoDbgStop<CR>", { desc = "Stop debugging" })
      map("n", "<leader>dp", ":GoDbgPrint<CR>", { desc = "Debug print variable" })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  
  -- Additional Go syntax and treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gosum" })
      end
    end,
  },
  
  -- Go snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Load Go snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/go" } })
    end,
  },
} 