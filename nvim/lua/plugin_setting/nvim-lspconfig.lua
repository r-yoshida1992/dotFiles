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
		local on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")
			local filename = vim.api.nvim_buf_get_name(bufnr)
			if filename:find(vim.fn.stdpath("cache") .. "/java%-src/", 1, false) then
				vim.diagnostic.enable(false, { bufnr = bufnr })
			end
		end
		local jump_to_java_source = function(class_name)
			local fqcn = class_name
			if not fqcn:find("%.") then
				for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
					local imported = line:match("^%s*import%s+([%w%.]+%." .. vim.pesc(fqcn) .. ")%s*;")
					if imported then
						fqcn = imported
						break
					end
				end
			end
			if not fqcn:find("%.") then
				fqcn = "java.lang." .. fqcn
			end

			local java_home_for_source = vim.fn.trim(vim.fn.system("/usr/libexec/java_home -v 25"))
			if vim.v.shell_error ~= 0 or java_home_for_source == "" then
				java_home_for_source = vim.fn.trim(vim.fn.system("/usr/libexec/java_home"))
			end

			local src_zip = java_home_for_source .. "/lib/src.zip"
			if vim.fn.filereadable(src_zip) == 0 then
				return false
			end

			local relative_path = fqcn:gsub("%.", "/") .. ".java"
			local entries = vim.fn.systemlist({ "unzip", "-Z1", src_zip })
			local zip_entry
			for _, entry in ipairs(entries) do
				if entry:sub(-#relative_path) == relative_path then
					zip_entry = entry
					break
				end
			end
			if not zip_entry then
				return false
			end

			local source = vim.fn.systemlist({ "unzip", "-p", src_zip, zip_entry })
			if vim.v.shell_error ~= 0 or #source == 0 then
				return false
			end

			local output_path = vim.fn.stdpath("cache") .. "/java-src/" .. zip_entry
			vim.fn.mkdir(vim.fn.fnamemodify(output_path, ":h"), "p")
			vim.fn.writefile(source, output_path)
			vim.cmd.edit(vim.fn.fnameescape(output_path))
			vim.diagnostic.enable(false, { bufnr = 0 })

			local short_name = fqcn:match("([%w_]+)$")
			for line_number, line in ipairs(source) do
				if line:match("%f[%w_]" .. vim.pesc(short_name) .. "%f[^%w_]") then
					vim.api.nvim_win_set_cursor(0, { line_number, 0 })
					break
				end
			end

			return true
		end
		local goto_definition = function()
			local params = vim.lsp.util.make_position_params(0, "utf-16")
			local responses = vim.lsp.buf_request_sync(0, "textDocument/definition", params, 1000)
			for _, response in pairs(responses or {}) do
				local result = response.result
				if result and not vim.tbl_isempty(result) then
					local location = result[1] or result
					vim.lsp.util.show_document(location, "utf-16", { focus = true })
					return
				end
			end

			if vim.bo.filetype == "java" and jump_to_java_source(vim.fn.expand("<cword>")) then
				return
			end

			vim.notify("definition not found", vim.log.levels.WARN)
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
				"sqlls",
				-- https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
				"rust_analyzer",
				"bashls",
				-- others
				"jsonls",
				"dockerls",
				"yamlls",
				"csharp_ls",
			},
			automatic_installation = true,
		})
		mason_lspconfig.setup_handlers({
			function(server)
				if server == "jdtls" then
					return
				end

				local opt = {
					on_attach = on_attach,
					capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
					settings = {
						["omnisharp"] = {
							useGlobalMono = "always",
						},
					},
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

		local jdtls_install_path = require("mason-registry").get_package("jdtls"):get_install_path()
		local java_home = vim.fn.trim(vim.fn.system("/usr/libexec/java_home -v 25"))
		if vim.v.shell_error ~= 0 or java_home == "" then
			java_home = vim.fn.trim(vim.fn.system("/usr/libexec/java_home"))
		end

		local jdtls_config = "config_mac"
		if vim.fn.has("mac") == 1 and vim.uv.os_uname().machine == "arm64" then
			jdtls_config = "config_mac_arm"
		elseif vim.fn.has("unix") == 1 and vim.uv.os_uname().machine == "aarch64" then
			jdtls_config = "config_linux_arm"
		elseif vim.fn.has("unix") == 1 then
			jdtls_config = "config_linux"
		elseif vim.fn.has("win32") == 1 then
			jdtls_config = "config_win"
		end

		lspconfig.jdtls.setup({
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-javaagent:" .. jdtls_install_path .. "/lombok.jar",
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--enable-native-access=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				vim.fn.glob(jdtls_install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
				"-configuration",
				jdtls_install_path .. "/" .. jdtls_config,
				"-data",
				vim.fn.stdpath("cache") .. "/jdtls/workspace",
			},
			on_attach = on_attach,
			capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			root_dir = require("lspconfig").util.root_pattern("gradlew", "mvnw", "settings.gradle", "build.gradle", "pom.xml", ".git"),
			settings = {
				java = {
					configuration = {
						runtimes = {
							{
								name = "JavaSE-25",
								path = java_home,
								default = true,
							},
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
				},
			},
		})

		-- cmp_nvim_lspの設定
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- lspconfigの設定
		lspconfig.csharp_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				return require("lspconfig").util.root_pattern("*.sln", "*.csproj", ".git")(fname) or vim.fn.getcwd()
			end,
		})

		-- キーマッピング
		-- ヒントを表示
		vim.keymap.set("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
		-- 定義元ジャンプ
		vim.keymap.set("n", "gd", goto_definition)
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
		-- vim.g.rustfmt_autosave = 1

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

		-- sign({ name = "DiagnosticSignError", text = "" })
		sign({ name = "DiagnosticSignError", text = "✖︎" })
		sign({ name = "DiagnosticSignWarn", text = "" })
		-- sign({ name = "DiagnosticSignHint", text = "" })
		sign({ name = "DiagnosticSignHint", text = "?" })
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
