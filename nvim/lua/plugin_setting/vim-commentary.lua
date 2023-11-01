return {
	"tpope/vim-commentary",
	event = { "VimEnter" },
	config = function()
		-- コメントアウト
		vim.api.nvim_set_keymap("n", "<space>c", "gcc", {})
	end,
}
