return {
	"nvim-telescope/telescope.nvim",
	cmd = {
		"Telescope",
	},
	event = { "BufReadPre", "BufNewFile" },
	keys = { { "ff", mode = "n" }, { "fg", mode = "n" }, { "fb", mode = "n" }, { "fh", mode = "n" } },
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			defaults = {
				color_devicons = true,
				file_ignore_patterns = { ".git/" },
				selection_caret = "  ",
				prompt_prefix = "   ",
			},
			pickers = {
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
		})

		local status, telescope = pcall(require, "telescope")
		if not status then
			return
		end

		local builtin = require("telescope.builtin")

		local keyset = vim.keymap.set

		-- ファイル名で検索
		keyset("n", "ff", builtin.find_files, {})

		-- ファイルに含まれる文字列で検索
		keyset("n", "fg", builtin.live_grep, {})

		-- neovimで開いているバッファで検索
		keyset("n", "fb", builtin.buffers, {})

		-- helpを開く
		keyset("n", "fh", builtin.help_tags, {})
	end,
}
