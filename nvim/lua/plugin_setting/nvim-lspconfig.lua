return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local mason_status, mason = pcall(require, "mason")
		local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
		local lspconfig_status, lspconfig = pcall(require, "lspconfig")
		local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		local cmp_status, cmp = pcall(require, "cmp")
		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				-- languages
				"html",
				"cssls",
				"tsserver",
				"gopls",
				"lua_ls",
				"jdtls",
				-- https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
				"rust_analyzer",
				"bashls",
				-- others
				"jsonls",
				"dockerls",
				"yamlls",
			},
			automatic_installation = true,
		})
		mason_lspconfig.setup_handlers({
			function(server)
				local opt = {
					capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
				}
				lspconfig[server].setup(opt)
			end,
		})

		-- LuaのLSPの設定をオーバーライドする
		-- 参考: https://github.com/cpdean/cpd.dotfiles/blob/7da9ac7f64857cb5139f6623bd8ca0eaf63ddd5f/config/nvim/lua/cpdean_config/nvim-lsp.lua#L326-L375
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						-- vimというグローバル変数を認識させる
						globals = { "vim", "use" },
					},
					workspace = {
						-- Neovimのランタイムパス内のファイルをライブラリとして利用するようする
						library = vim.api.nvim_get_runtime_file("", true),
						-- サードパーティライブラリのチェックを無効化する
						checkThirdParty = false,
					},
					-- テレメトリ（統計情報）を無効に設定
					telemetry = {
						enable = false,
					},
				},
			},
		})

		lspconfig.rust_analyzer.setup({
			cmd = { "rust_analyzer" },
		})

		-- キーマッピング
		-- ヒントを表示
		vim.keymap.set("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
		-- 定義元ジャンプ
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
		-- カーソル下の変数をコード内で参照している箇所を一覧表示
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
		-- エラーを表示
		vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
		-- コードアクションを表示
		vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		-- コードアクションを表示
		vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>")

		-- LSP handlers
		-- LSPサーバーから送信される"publishDiagnostics"メッセージを処理する際に、仮想テキストとしてエラー情報を表示しないようにする
		vim.lsp.handlers["textDocument/publishDiagnostics"] =
			vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

		-- rust format
		vim.g.rustfmt_autosave = 1

		--
		-- Completion settings (hrsh7th/nvim-cmp)
		--
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
			},
			mapping = cmp.mapping.preset.insert({
				-- enterで補完を確定する
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			experimental = {
				ghost_text = true,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "single",
				}),
				documentation = cmp.config.window.bordered({
					border = "single",
				}),
			},
		})

		-- LSP Diagnostics Options Setup
		local sign = function(opts)
			vim.fn.sign_define(opts.name, {
				texthl = opts.name,
				text = opts.text,
				numhl = "",
			})
		end

		sign({ name = "DiagnosticSignError", text = "" })
		sign({ name = "DiagnosticSignWarn", text = "" })
		sign({ name = "DiagnosticSignHint", text = "" })
		sign({ name = "DiagnosticSignInfo", text = "" })

		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			update_in_insert = true,
			underline = true,
			severity_sort = false,
			float = {
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
	end,
}
