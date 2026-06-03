return {
	"nvim-telescope/telescope.nvim",
	event = { "VeryLazy" },
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			defaults = {
				color_devicons = true,
				-- file_ignore_patterns = { ".git/", "volumes/" },
				file_ignore_patterns = {
					".git/",
					"node_modules/",
					"build/",
					".gradle/",
					"volumes/",
					".meta",
					".png",
					".asset",
					".anim",
					".unity",
					-- ".controller",
					".prefab",
				},
				selection_caret = "  ",
				prompt_prefix = "   ",
				preview = {
					treesitter = false,
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
				},
				live_grep = {
					additional_args = function(opts)
						return {
							"--hidden",
							"--no-ignore",
							"--glob",
							"!front/node_modules/**",
							"--glob",
							"!core/api/build/**",
							"--glob",
							"!core/api/.gradle/**",
						}
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

		-- 環境変数NVIM_TELESCOPE_SEARCH_DIRSに検索ディレクトリを設定している場合は、環境変数の値を検索ディレクトリとして使用する
		local search_dirs_env = os.getenv("NVIM_TELESCOPE_SEARCH_DIRS")
		if not search_dirs_env then
			error("Environment variable NVIM_TELESCOPE_SEARCH_DIRS is not set")
			return
		end

		local function split_string(inputstr, sep)
			if sep == nil then
				sep = "%s"
			end
			local t = {}
			for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
				table.insert(t, str)
			end
			return t
		end

		local search_dirs = split_string(search_dirs_env, ":")
		print("search_dirs: " .. vim.inspect(search_dirs))

		keyset("n", "f-", function()
			builtin.find_files({
				search_dirs = search_dirs,
			})
		end, {})

		-- ファイルに含まれる文字列で検索
		keyset("n", "fg", builtin.live_grep, {})

		keyset("n", "f~", function()
			builtin.live_grep({
				search_dirs = search_dirs,
			})
		end, {})

		keyset("n", "<space><space>", function()
			builtin.find_files({
				search_dirs = { "~/memo" },
			})
		end, {})

		-- neovimで開いているバッファで検索
		keyset("n", "fb", builtin.buffers, {})

		-- helpを開く
		keyset("n", "fh", builtin.help_tags, {})

		-- select git branch
		keyset("n", "<leader>gb", builtin.git_branches, {})

		-- show git status
		keyset("n", "<leader>gs", builtin.git_status, {})
	end,
}
