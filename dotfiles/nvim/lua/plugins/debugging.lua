return {
	"mfussenegger/nvim-dap",
	dependencies = { 
		"rcarriga/nvim-dap-ui", 
		"nvim-neotest/nvim-nio", 
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		require("dap-go").setup()
		
		-- Setup Python debug adapter
		require("dap-python").setup("python", {
			-- Use system Python or specify path
			-- pythonPath = "/usr/bin/python3",
		})
		
		-- Simple DAP UI setup
		require("dapui").setup({
			layouts = {
				{
					elements = {
						-- Có thể sắp xếp lại thứ tự tùy ý
						{ id = "watches", size = 0.2 },     -- Watch expressions
						{ id = "stacks", size = 0.2 },      -- Call stack  
						{ id = "breakpoints", size = 0.3 }, -- Breakpoints
						{ id = "scopes", size = 0.3 },      -- Variables
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "console", size = 0.5 }, -- Program output
						{ id = "repl", size = 0.5 },    -- REPL interactive
						
					},
					size = 0.25, -- 25% of screen
					position = "bottom",
				},
			},
		})

		-- System LLDB-DAP adapter (recommended for NixOS)
		dap.adapters.lldb = {
			type = "executable",
			command = "/run/current-system/sw/bin/lldb-dap",
			name = "lldb"
		}
		
		-- GDB adapter (most popular and stable)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" }
		}

		-- C++ debugging configuration (simplified)
		dap.configurations.cpp = {
			{
				name = "Launch (LLDB)",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Launch (GDB)",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- C configuration (same as C++)
		dap.configurations.c = dap.configurations.cpp

		-- Python debugging configuration
		dap.configurations.python = {
			{
				name = "Launch Python File",
				type = "python",
				request = "launch",
				program = "${file}",
				console = "integratedTerminal",
				justMyCode = true,
			},
			{
				name = "Launch Python Module",
				type = "python",
				request = "launch",
				module = function()
					return vim.fn.input("Module name: ")
				end,
				console = "integratedTerminal",
				justMyCode = true,
			},
			{
				name = "Attach to Process",
				type = "python",
				request = "attach",
				processId = function()
					return vim.fn.input("Process ID: ")
				end,
				justMyCode = true,
			},
			{
				name = "Debug Current File",
				type = "python",
				request = "launch",
				program = "${file}",
				console = "integratedTerminal",
				justMyCode = false, -- Include library code
			},
		}

		-- Auto open/close UI
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		
		-- Basic keymaps
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<Leader>ds", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
		vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
		vim.keymap.set("n", "<Leader>dT", dap.terminate, { desc = "Terminate" })
		
		-- Advanced UI keymaps - individual element control
		vim.keymap.set("n", "<Leader>dv", function() dapui.float_element("scopes") end, { desc = "Float Variables" })
		vim.keymap.set("n", "<Leader>db", function() dapui.float_element("breakpoints") end, { desc = "Float Breakpoints" })
		vim.keymap.set("n", "<Leader>dk", function() dapui.float_element("stacks") end, { desc = "Float Call Stack" })
		vim.keymap.set("n", "<Leader>dw", function() dapui.float_element("watches") end, { desc = "Float Watches" })
		vim.keymap.set("n", "<Leader>df", function() dapui.float_element("repl") end, { desc = "Float REPL" })
		vim.keymap.set("n", "<Leader>dx", function() dapui.float_element("console") end, { desc = "Float Console" })
		
		-- Quick fold toggle in DAP windows
		vim.keymap.set("n", "<Leader>dz", function() 
			-- Focus scopes window and toggle all folds
			dapui.open()
			local wins = vim.api.nvim_list_wins()
			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				local buf_name = vim.api.nvim_buf_get_name(buf)
				if buf_name:match("dapui_scopes") then
					vim.api.nvim_set_current_win(win)
					vim.cmd("normal! zM") -- Close all folds
					break
				end
			end
		end, { desc = "Close all folds in Variables" })
		
		-- Layout switching (if you want to switch layouts dynamically)
		-- vim.keymap.set("n", "<Leader>d1", function() 
		--     dapui.close()
		--     -- Switch to layout 1 and reopen
		--     dapui.open()
		-- end, { desc = "Switch to Layout 1" })
	end,
}

-- Installation instructions:
-- 1. :MasonInstall codelldb
-- 2. Compile with debug symbols: g++ -g -o program program.cpp  
-- 3. If CodeLLDB fails, GDB will be used as fallback
-- 4. Use <Leader>di to check debug adapter status
-- 5. For Python: Install debugpy: pip install debugpy
