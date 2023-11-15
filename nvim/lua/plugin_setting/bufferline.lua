return {
	"akinsho/bufferline.nvim",
	event = { "VimEnter" },
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		vim.cmd("lua << EOF")
		require("bufferline").setup({})
	end,
}
