return {
	"lewis6991/gitsigns.nvim",
	event = { "VeryLazy" },
	config = function()
		require("gitsigns").setup()
		vim.cmd([[
      autocmd BufReadPost * :lua require'gitsigns'.toggle_current_line_blame()
    ]])
	end,
}
