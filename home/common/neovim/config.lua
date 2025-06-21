-- ===== BASIC SETTINGS =====
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4           -- C++ thường dùng 4 spaces
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
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"   -- C++ coding standard

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

-- C++ specific settings
vim.opt.cindent = true
vim.opt.cinoptions = "g0,N-s,E-s,f0,{0,}0,^-1s,:1s,=1s,l1,b1,gs,hs,ps,ts,is,+1s,c3,C0,/0,(2s,us,U1,w1,W1,m1,j1,J1"

-- Colorscheme
vim.cmd([[colorscheme tokyonight-night]])

-- ===== KEYMAPS =====

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
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-h>", "<C-w>")
vim.keymap.set("i", "<C-Del>", "<C-o>dw")

-- Page Up/Down với centering
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")
vim.keymap.set("i", "<PageUp>", "<C-o><C-u><C-o>zz")
vim.keymap.set("i", "<PageDown>", "<C-o><C-d><C-o>zz")

-- Home/End keys
vim.keymap.set("n", "<Home>", "^")
vim.keymap.set("n", "<End>", "$")
vim.keymap.set("i", "<Home>", "<C-o>^")
vim.keymap.set("i", "<End>", "<C-o>$")
vim.keymap.set("v", "<Home>", "^")
vim.keymap.set("v", "<End>", "$")

-- Ctrl+Home/End
vim.keymap.set("n", "<C-Home>", "gg")
vim.keymap.set("n", "<C-End>", "G")
vim.keymap.set("i", "<C-Home>", "<C-o>gg")
vim.keymap.set("i", "<C-End>", "<C-o>G")

-- Ctrl+Left/Right
vim.keymap.set("n", "<C-Left>", "b")
vim.keymap.set("n", "<C-Right>", "w")
vim.keymap.set("i", "<C-Left>", "<C-o>b")
vim.keymap.set("i", "<C-Right>", "<C-o>w")
vim.keymap.set("v", "<C-Left>", "b")
vim.keymap.set("v", "<C-Right>", "w")

-- Selection keymaps
vim.keymap.set("n", "<S-Left>", "vh")
vim.keymap.set("n", "<S-Right>", "vl")
vim.keymap.set("n", "<S-Up>", "vk")
vim.keymap.set("n", "<S-Down>", "vj")
vim.keymap.set("v", "<S-Left>", "h")
vim.keymap.set("v", "<S-Right>", "l")
vim.keymap.set("v", "<S-Up>", "k")
vim.keymap.set("v", "<S-Down>", "j")

-- Ctrl+Shift selection
vim.keymap.set("n", "<C-S-Left>", "vb")
vim.keymap.set("n", "<C-S-Right>", "vw")
vim.keymap.set("v", "<C-S-Left>", "b")
vim.keymap.set("v", "<C-S-Right>", "w")

-- Standard editor shortcuts
vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set("i", "<C-a>", "<C-o>ggVG")
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("n", "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", '<C-o>"+p')
vim.keymap.set("v", "<C-x>", '"+d')
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>")
vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("i", "<C-z>", "<C-o>u")
vim.keymap.set("n", "<C-y>", "<C-r>")
vim.keymap.set("i", "<C-y>", "<C-o><C-r>")

-- Tab indentation
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")

-- Comment toggle
vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")

-- F3 for search next
vim.keymap.set("n", "<F3>", "n")

-- Escape alternatives
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Window resizing
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- ===== C++ SPECIFIC KEYMAPS =====

-- Compile and run (F5)
vim.keymap.set("n", "<F5>", ":w<CR>:!g++ -std=c++17 -O2 -Wall -Wextra -o %:r % && ./%:r<CR>")

-- Compile only (F6)
vim.keymap.set("n", "<F6>", ":w<CR>:!g++ -std=c++17 -O2 -Wall -Wextra -o %:r %<CR>")

-- Run with input file (F7)
vim.keymap.set("n", "<F7>", ":w<CR>:!g++ -std=c++17 -O2 -Wall -Wextra -o %:r % && ./%:r < input.txt<CR>")

-- Debug compile (F8)
vim.keymap.set("n", "<F8>", ":w<CR>:!g++ -std=c++17 -g -Wall -Wextra -o %:r % && gdb ./%:r<CR>")

-- Format code
vim.keymap.set("n", "<leader>cf", ":!clang-format -i %<CR>")

-- Create competitive programming template
vim.keymap.set("n", "<leader>cp", ":CppTemplate<CR>")

-- Quick test
vim.keymap.set("n", "<leader>ct", ":!./%:r < test.txt<CR>")

-- Built-in code runner alternative
vim.keymap.set("n", "<leader>r", ":w<CR>:!g++ -std=c++17 -O2 -Wall -Wextra -o %:r % && ./%:r<CR>")
vim.keymap.set("n", "<leader>rf", ":w<CR>:!g++ -std=c++17 -O2 -Wall -Wextra -o %:r % && ./%:r < input.txt<CR>")

-- ===== PLUGIN CONFIGURATIONS =====

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Telescope setup
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git", "build", "*.o", "*.exe"}
  }
}

-- Nvim-tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Trouble (diagnostics)
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)

-- ===== PLUGIN SETUP =====

-- Nvim-tree
require('nvim-tree').setup{
  view = {
    width = 30,
  },
  filters = {
    dotfiles = false,
  },
}

-- Lualine
require('lualine').setup{
  options = {
    theme = 'tokyonight'
  }
}

-- Gitsigns
require('gitsigns').setup{}

-- Comment
require('Comment').setup{}

-- Autopairs
require('nvim-autopairs').setup{}

-- Which-key
require('which-key').setup{}

-- Trouble
require("trouble").setup{}

-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

-- ===== LSP CONFIGURATION =====

local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Global LSP keymaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- LSP attach function
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Clangd setup for C++
lsp.clangd.setup{
  capabilities = capabilities,
  on_attach = on_attach,
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
}

-- Other LSP servers
lsp.nil_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

lsp.lua_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }
}

-- ===== COMPLETION SETUP =====

local cmp = require'cmp'
local luasnip = require'luasnip'

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

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
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
})

-- ===== DAP (DEBUGGING) SETUP =====

local dap = require('dap')
local dapui = require('dapui')

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

-- C++ debugger configuration
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- Debug keymaps
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<S-F11>', dap.step_out)
vim.keymap.set('n', '<leader>dr', dap.repl.open)
vim.keymap.set('n', '<leader>dc', dap.continue)

-- ===== AUTO COMMANDS =====

-- Auto-format C++ files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.cpp", "*.c", "*.h", "*.hpp"},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Set filetype for competitive programming files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.cpp", "*.cc", "*.cxx"},
  callback = function()
    vim.bo.filetype = "cpp"
  end,
})

-- ===== CUSTOM FUNCTIONS =====

-- Create competitive programming template
local function create_cpp_template()
  local template = [[
#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define vi vector<int>
#define vll vector<long long>
#define pii pair<int, int>
#define pll pair<long long, long long>
#define all(x) x.begin(), x.end()
#define sz(x) (int)x.size()

void solve() {
    // Your solution here
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    
    int t = 1;
    // cin >> t;
    
    while (t--) {
        solve();
    }
    
    return 0;
}
]]
  
  local lines = {}
  for line in template:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

-- Command to create template
vim.api.nvim_create_user_command('CppTemplate', create_cpp_template, {})

-- Quick input/output file creation
vim.api.nvim_create_user_command('CreateIO', function()
  vim.cmd('edit input.txt')
  vim.cmd('vsplit output.txt')
end, {}) 