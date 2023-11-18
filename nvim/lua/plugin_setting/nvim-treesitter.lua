return {
	-- シンタックスハイライトをリッチにする
	"nvim-treesitter/nvim-treesitter",
	run = { ":TSUpdate" },
	event = { "VeryLazy" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "rust", "toml", "prisma", "css", "javascript", "typescript", "tsx" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ident = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		})
	end,
}
