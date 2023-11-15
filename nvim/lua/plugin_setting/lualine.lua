return {
	"nvim-lualine/lualine.nvim",
	event = { "VimEnter" },
	dependencies = { "r-yoshida1992/nightly.nvim" },
	config = function()
		require("lualine").setup({
			options = { theme = "nightly" },
		})
	end,
}
