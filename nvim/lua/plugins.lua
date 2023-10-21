local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set mapleader
vim.g.mapleader = " "

require("lazy").setup({
	-- status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- カラーコードの色を見えやすいように表示
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- ファイラー
	{
		"lambdalisue/fern.vim",
		dependencies = {
			"lambdalisue/fern-renderer-devicons.vim",
			"lambdalisue/glyph-palette.vim",
			"lambdalisue/fern-git-status.vim",
		},
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- コメントアウトを効率化
	"terrortylor/nvim-comment",

	-- プロジェクトルートをカレントディレクトリにする
	"mattn/vim-findroot",

	-- テーマ
	"EdenEast/nightfox.nvim",

	-- アイコンフォント
	"ryanoasis/vim-devicons",

	-- vim-commentaryプラグインを追加する（コメントアウトを簡単にする）
	"tpope/vim-commentary",

	-- markdown-preview.nvimプラグインを追加する（Markdownのプレビュー）
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
	},

	-- stylua-nvimプラグインを追加する（Luaのコードフォーマッター）
	{
		"ckipp01/stylua-nvim",
		run = "cargo install stylua",
	},

	-- 日本語化プラグインを追加する
	"vim-jp/vimdoc-ja",

	-- vim-prettierプラグインを追加する（PrettierのVimインテグレーション）
	{
		"prettier/vim-prettier",
		run = "yarn install --frozen-lockfile --production",
		branch = "release/0.x",
	},

	-- 各種Lintを非同期実行
	"w0rp/ale",

	-- rust
	"rust-lang/rust.vim",

	-- Language Server Protocol
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/vim-vsnip",
})
