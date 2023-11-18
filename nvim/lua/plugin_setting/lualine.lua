return {
	"nvim-lualine/lualine.nvim",
	event = { "VeryLazy" },
	dependencies = { "r-yoshida1992/nightly.nvim" },
	config = function()
		require("lualine").setup({
			options = { theme = "nightly" },
		})
	end,
}
