return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  priority = 1000,
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = 'node',
      server_opts_overrides = {
        trace = "verbose", -- Bật verbose logging
        settings = {
          advanced = {
            modelSelection = true,
            listCount = 10,
            inlineSuggestCount = 3,
          }
        }
      },
    })

    -- Đảm bảo Copilot khởi động
    vim.defer_fn(function()
      vim.cmd("Copilot enable")
    end, 1000)
  end,
  keys = {
    { "<leader>cp", ":Copilot panel<CR>", desc = "Copilot panel" },
    { "<leader>cs", ":Copilot status<CR>", desc = "Copilot status" },
    { "<leader>ce", ":Copilot enable<CR>", desc = "Copilot enable" },
    { "<leader>cd", ":Copilot disable<CR>", desc = "Copilot disable" },
  },
}
