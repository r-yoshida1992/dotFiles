return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	config = function()
		-- mpでMarkdownをプレビューする
		vim.api.nvim_set_keymap("n", "mp", ":MarkdownPreview<CR>", {})
	end,
	ft = { "markdown" },
}
