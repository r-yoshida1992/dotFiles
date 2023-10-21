require("chatgpt").setup({
	-- read $OPENAI_API_KEY
	api_key_cmd = "op read op://private/OpenAI/credential --no-newline",
})

vim.api.nvim_set_keymap("n", "ch", ":ChatGPT<CR>", { silent = true })
