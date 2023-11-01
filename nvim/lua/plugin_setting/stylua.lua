return {
	"ckipp01/stylua-nvim",
	run = "cargo install stylua",
	keys = { { "w", mode = "n" } },
	config = function()
		vim.cmd([[  
			augroup LuaAutoFmt
				autocmd!
				" luaのフォーマット
				autocmd BufWritePre *.lua :lua require('stylua-nvim').format_file()
			augroup END
		]])
	end,
}
