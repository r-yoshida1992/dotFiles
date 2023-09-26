require("packer").startup(function()
	-- packer.nvimプラグインを追加する（プラグマネージャー）
	use("wbthomason/packer.nvim")
	-- vim-airlineプラグインを追加する（状態行のカスタマイズ）
	use("vim-airline/vim-airline")
	-- vim-airline-themesプラグインを追加する（状態行のテーマ）
	use("vim-airline/vim-airline-themes")
	-- fzfプラグインを追加する（高速なファジーファインダー）
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})
	-- fzf.vimプラグインを追加する（fzfのVimインターフェース）
	use("junegunn/fzf.vim")
	-- rust.vimプラグインを追加する（Rust言語のサポート）
	use("rust-lang/rust.vim")
	-- gitsigns.nvimプラグインを追加する（Gitの変更を表示する）
	use("lewis6991/gitsigns.nvim")
	-- vim-prettierプラグインを追加する（PrettierのVimインテグレーション）
	use({ "prettier/vim-prettier", run = "yarn install --frozen-lockfile --production", branch = "release/0.x" })
	-- nerdfont.vimプラグインを追加する（Nerd Fontのサポート）
	use({ "lambdalisue/nerdfont.vim" })
	-- fern.vimプラグインを追加する（ファイルエクスプローラー）
	use({ "lambdalisue/fern.vim", requires = { "lambdalisue/nerdfont.vim" } })
	-- fern-renderer-nerdfont.vimプラグインを追加する（Nerd Fontのサポート）
	use({ "lambdalisue/fern-renderer-nerdfont.vim", requires = { "lambdalisue/fern.vim", "lambdalisue/nerdfont.vim" } })
	-- fern-git-status.vimプラグインを追加する（Gitの状態を表示する）
	use({ "lambdalisue/fern-git-status.vim", requires = { "lambdalisue/fern.vim" } })
	-- nui.nvimプラグインを追加する（NeovimのUIをLuaで構築する）
	use({ "MunifTanjim/nui.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- plenary.nvimプラグインを追加する（Luaのユーティリティ関数）
	use({ "nvim-lua/plenary.nvim" })
	-- telescope.nvimプラグインを追加する（拡張性の高いファジーファインダー）
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- vim-commentaryプラグインを追加する（コメントアウトを簡単にする）
	use({ "tpope/vim-commentary" })
	-- vim-polyglotプラグインを追加する（多言語のサポート）
	use({ "sheerun/vim-polyglot" })
	-- markdown-preview.nvimプラグインを追加する（Markdownのプレビュー）
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
	-- stylua-nvimプラグインを追加する（Luaのコードフォーマッター）
	use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })
	-- 日本語化プラグインを追加する
	use({ "vim-jp/vimdoc-ja" })
	-- formatter
	use({ "mhartington/formatter.nvim" })

	-- Language Server Protocol
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/vim-vsnip" })

end)
