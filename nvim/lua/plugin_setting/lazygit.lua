return {
	"kdheepak/lazygit.nvim",
	event = { "VimEnter" },
	config = function()
		vim.keymap.set("n", "gv", ":LazyGit<CR>")
	end,
}
