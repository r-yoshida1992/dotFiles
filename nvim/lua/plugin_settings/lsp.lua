local mason_status, mason = pcall(require, "mason")
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local cmp_status, cmp = pcall(require, "cmp")

if
	not mason_status
	and not mason_lspconfig_status
	and not lspconfig_status
	and not cmp_nvim_lsp_status
	and not cmp_status
then
	return
end

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

-------------- java

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
local path_to_lsp_server = jdtls_path .. "config_mac_arm"
local path_to_plugins = jdtls_path .. "plugins/"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"
local lombok_path = jdtls_path .. "lombok.jar"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir " .. workspace_dir)

-- Main Config
local config = {}

config["on_attach"] = function(client, bufnr)
	require("keymaps").map_java_keys(bufnr)
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		floating_window_above_cur_line = false,
		padding = "",
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

lspconfig.jdtls.setup({
	cmd = {
		"/opt/homebrew/opt/openjdk@21/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. lombok_path,
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		path_to_jar,
		"-configuration",
		path_to_lsp_server,
		"-data",
		workspace_dir,
	},
	root_dir = function(fname)
		return require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, fname)
	end,
	settings = {

		java = {
			home = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-18.0.1/Contents/Home/",
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-18",
						path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-18.0.1/Contents/Home",
					},
					{
						name = "JavaSE-17",
						path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-17.0.4/Contents/Home",
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
				"javax.persistence.*",
			},
			importOrder = {
				"java",
				"javax",
				"com",
				"org",
			},
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},
})

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
-- require("jdtls").start_or_attach(config)
-------------- java

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
