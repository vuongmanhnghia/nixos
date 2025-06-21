return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        -- Thêm pcall để tránh crash
        local ok, fzf = pcall(require, "fzf-lua")
        if not ok then
            vim.notify("Failed to load fzf-lua", vim.log.levels.ERROR)
            return
        end
        
        fzf.setup({
            -- Cấu hình của bạn giữ nguyên
            winopts = {
                height = 0.85,
                width = 0.90,
                preview = {
                    layout = "horizontal",
                },
            },
            fzf_colors = {
                true,
                bg = "-1", 
                gutter = "-1",
            },
            keymap = {
                fzf = { ["ctrl-q"] = "select-all+accept" },
            },
        })
        
        -- Keymaps với error handling
        vim.keymap.set("n", "<leader>ff", function()
            pcall(fzf.files)
        end, { desc = "Find Files" })
        
        vim.keymap.set("n", "<leader>pf", function()
            pcall(fzf.git_files)
        end, { desc = "Find Git Files" })
        
        vim.keymap.set("n", "<leader>fg", function()
            pcall(fzf.live_grep)
        end, { desc = "Live Grep" })
        
        -- Các keymap khác tương tự...
    end,
}
