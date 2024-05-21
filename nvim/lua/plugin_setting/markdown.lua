return {
	"MeanderingProgrammer/markdown.nvim",
	event = { "VeryLazy" },
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("render-markdown").setup({
			start_enabled = false,
		})
		-- キーマッピングの設定を追加
		vim.api.nvim_set_keymap("n", "<leader>md", ":RenderMarkdownToggle<CR>", { noremap = true, silent = true })
	end,
}
