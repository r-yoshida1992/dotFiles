return {
	"iamcco/markdown-preview.nvim",
	run = "cd app && yarn install",
	keys = { "mp", "n" },
	ft = { "md" },
	event = { "VimEnter" },
	config = function()
		-- mpでMarkdownをプレビューする
		vim.api.nvim_set_keymap("n", "mp", ":MarkdownPreview<CR>", {})
	end,
}
