return {
	-- Python specific configurations
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
  			if not vim.tbl_contains(opts.ensure_installed, "python") then
    			table.insert(opts.ensure_installed, "python")
  			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- Python LSP configuration
		},
	},
	-- Python filetype specific settings
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.highlight = opts.highlight or {}
			opts.highlight.additional_vim_regex_highlighting = false
		end,
	},
	-- Auto-format Python files on save
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- Auto-format on save for Python
			format = {
				async = true,
				timeout_ms = 5000,
			},
		},
	},
	-- Python specific keymaps
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			-- Add Python specific keymaps
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function()
					-- Set Python specific indentation
					vim.opt_local.tabstop = 4
					vim.opt_local.shiftwidth = 4
					vim.opt_local.softtabstop = 4
					vim.opt_local.expandtab = true
					
					-- Python specific keymaps
					vim.keymap.set("n", "<leader>rf", function()
						-- Run current Python file
						local file_path = vim.fn.expand("%")
						if file_path == "" then
							vim.notify("No file to run", vim.log.levels.ERROR)
							return
						end
						vim.cmd("write") -- Tự động lưu file
						vim.cmd("!python3 " .. file_path)
					end, { buffer = true, desc = "Run Python file" })
					
					vim.keymap.set("n", "<leader>rp", function()
						-- Run Python file in terminal
						vim.cmd("write") -- Tự động lưu file
						vim.cmd("terminal python3 %")
    					vim.cmd("startinsert")  -- Tự động vào Insert mode để nhập input
					end, { buffer = true, desc = "Run Python in terminal" })
					
					vim.keymap.set("n", "<leader>ri", function()
						-- Run Python interactive
						vim.cmd("write") -- Tự động lưu file
						vim.cmd("terminal python3")
						vim.cmd("startinsert")  -- Tự động vào Insert mode để nhập input
					end, { buffer = true, desc = "Python interactive" })
				end,
			})

			
		end,
	},
} 