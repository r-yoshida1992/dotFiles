require("nightly").setup({
	transparent = false,
	styles = {
		comments = { italic = false, fg = "#888888" },
		functions = { italic = false },
		variables = { italic = false },
		keywords = { italic = false },
	},
	highlights = {},
})

-- colorの設定
vim.cmd("colorscheme nightly")
