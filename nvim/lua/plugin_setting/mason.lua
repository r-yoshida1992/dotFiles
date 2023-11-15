return {
	"williamboman/mason.nvim",
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
	},
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/vim-vsnip",
		"neovim/nvim-lspconfig",
	},
}
