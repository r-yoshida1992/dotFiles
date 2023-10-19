require("packer").startup(function()

	-- plugin manager
	use("wbthomason/packer.nvim")

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

  -- カラーコードの色を見えやすいように表示
  use {'norcalli/nvim-colorizer.lua',
    config = function ()
      require'colorizer'.setup()
    end,
  }

  -- ファイラー
  use {'lambdalisue/fern.vim',
    requires = {
      {'lambdalisue/fern-renderer-devicons.vim', 'lambdalisue/glyph-palette.vim', 'lambdalisue/fern-git-status.vim'},
    },
  }

  -- fuzzy finder 
  use {'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or, branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- コメントアウトを効率化
  use 'terrortylor/nvim-comment'

  -- ホバーしてる単語をカレントディレクトリ内から検索
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}

  -- ripgrepをnvim上で実行して、検索結果をQuickfixに表示
  use {'duane9/nvim-rg', opt = true, cmd ={'Rg'}}

  -- 複数ファイルの一括置換
  use {'thinca/vim-qfreplace', opt = true, cmd = {'Qfreplace'}}

  -- プロジェクトルートをカレントディレクトリにする
  use 'mattn/vim-findroot'

  -- テーマ
  use 'EdenEast/nightfox.nvim'

  -- アイコンフォント
  use 'ryanoasis/vim-devicons'

  -- vim-commentaryプラグインを追加する（コメントアウトを簡単にする）
	use({ "tpope/vim-commentary" })

	-- markdown-preview.nvimプラグインを追加する（Markdownのプレビュー）
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

	-- stylua-nvimプラグインを追加する（Luaのコードフォーマッター）
	use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })

	-- 日本語化プラグインを追加する
	use({ "vim-jp/vimdoc-ja" })

	-- vim-prettierプラグインを追加する（PrettierのVimインテグレーション）
	use({ "prettier/vim-prettier", run = "yarn install --frozen-lockfile --production", branch = "release/0.x" })

	-- Language Server Protocol
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/vim-vsnip" })
end)
