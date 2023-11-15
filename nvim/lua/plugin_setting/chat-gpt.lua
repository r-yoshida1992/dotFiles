return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	keys = { { "ch", mode = "n" } },
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("chatgpt").setup({
			-- read $OPENAI_API_KEY
			api_key_cmd = "op read op://private/OpenAI/credential --no-newline",
		})

		vim.api.nvim_set_keymap("n", "ch", ":ChatGPT<CR>", { silent = true })
	end,
}
