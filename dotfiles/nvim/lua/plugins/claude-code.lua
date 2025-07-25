return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        terminal_cmd = "TERM=screen-256color claude",
        terminal = {
            split_side = "right",
            split_width_percentage = 0.3,
            provider = "snacks",
        }
    },
    config = true,
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<cr>", mode = { "n", "v" }, desc = "Toggle Claude Terminal" },
        { "<leader>ak", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude Code" },
        { "<leader>ao", "<cmd>ClaudeCodeOpen<cr>", mode = { "n", "v" }, desc = "Open Claude Terminal" },
        { "<leader>ax", "<cmd>ClaudeCodeClose<cr>", mode = { "n", "v" }, desc = "Close Claude Terminal" },
    },
}
