return {
	"numToStr/Comment.nvim",
	opts = {
		-- Tùy chỉnh keymap nếu muốn
		toggler = {
		  line = "gcc",  -- Comment dòng
		  block = "gbc", -- Comment block
		},
		opleader = {
		  line = "gc",
		  block = "gb",
		},
		-- Tự động nhận diện filetype, không cần chỉnh gì cho Python
		pre_hook = nil,
		post_hook = nil,
	 },
	 config = function()
		require("Comment").setup()
	 end,
}
