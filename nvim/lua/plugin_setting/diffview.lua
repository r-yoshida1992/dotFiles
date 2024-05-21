return {
	"sindrets/diffview.nvim",
	event = { "VeryLazy" },
	config = function()
		require("diffview").setup({})
		vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
		vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>")
		vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>")
	end,
}
