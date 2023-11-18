return {
	"kdheepak/lazygit.nvim",
	event = { "VeryLazy" },
	config = function()
		vim.keymap.set("n", "<space>gv", ":LazyGit<CR>")
	end,
}
