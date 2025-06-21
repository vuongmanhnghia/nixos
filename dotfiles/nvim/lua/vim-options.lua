vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- paste over highlight word
vim.keymap.set("x", "<leader>p", '"_dP')

-- Word deletion keymaps
-- Ctrl+Backspace: delete word backward in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>")
-- Ctrl+Delete: delete word forward in insert mode  
vim.keymap.set("i", "<C-Del>", "<C-o>dw")
-- Alternative mapping for terminals that don't support C-BS
vim.keymap.set("i", "<C-h>", "<C-w>")

-- Keymap đóng terminal buffer và trở về file
vim.keymap.set('t', '<leader>q', function()
	vim.cmd('stopinsert')
	vim.cmd('q')
end, { desc = "Đóng terminal và trở về file" })
vim.keymap.set('n', '<leader>q', function()
	vim.cmd('q')
end, { desc = "Đóng terminal và trở về file" })

vim.opt.colorcolumn = "94"
-- fk llm-ls
local notify_original = vim.notify
vim.notify = function(msg, ...)
	if
		msg
		and (
			msg:match("position_encoding param is required")
			or msg:match("Defaulting to position encoding of the first client")
			or msg:match("multiple different client offset_encodings")
		)
	then
		return
	end
	return notify_original(msg, ...)
end
vim.opt.swapfile = false
