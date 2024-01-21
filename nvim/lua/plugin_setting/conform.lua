return {
	"stevearc/conform.nvim",
	event = { "VeryLazy" },
	dependencies = { "ckipp01/stylua-nvim" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				rust = { "rustfmt" },
				sql = { "sqlfmt" },
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.xml",
			callback = function()
				vim.cmd(":%!xmllint --format -")
			end,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
