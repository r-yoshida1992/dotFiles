return {
	"zbirenbaum/copilot.lua",
	event = { "VeryLazy" },
	dependencies = {
		"github/copilot.vim",
	},
	config = function()
		require("copilot").setup({})
	end,
}
