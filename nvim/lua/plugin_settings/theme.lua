-- colorの設定
vim.cmd("colorscheme nightly")

require("nightly").setup({
	transparent = false,
	styles = {
		comments = { italic = true, fg = "#707070" },
		functions = { italic = false },
		variables = { italic = false },
		keywords = { italic = false },
	},
	highlights = {},
})
