return {
	"lambdalisue/fern.vim",
	keys = { { "fe" } },
	event = "VeryLazy",
	dependencies = {
		"lambdalisue/fern-renderer-devicons.vim",
		"lambdalisue/glyph-palette.vim",
		"lambdalisue/fern-git-status.vim",
		"ryanoasis/vim-devicons",
	},
	config = function()
		function OpenFernWithCommand()
			vim.cmd(":cd " .. GetGitRoot())
			vim.cmd(":Fern . -reveal=% -drawer")
		end

		vim.api.nvim_set_keymap("n", "fe", ":lua OpenFernWithCommand()<CR>", {})
		-- fe を押すとサイドにファイルツリーを表示します
		-- vim.api.nvim_set_keymap("n", "fe", ":Fern . -reveal=% -drawer<CR>", { noremap = true, silent = true })
		-- vim.api.nvim_set_keymap("n", "fe", ":Fern . -reveal=% -drawer<CR>", {})

		vim.cmd([[
			let g:fern#renderer = 'devicons'
			let g:fern#default_hidden = 1
			let g:fern#drawer_width = 40
			let g:fern_disable_startup_warnings = 1
		
			function! s:init_fern() abort
				" Write custom code here
				
				nmap <buffer> i <Plug>(fern-action-open:split)
				nmap <buffer> s <Plug>(fern-action-open:vsplit)
		
				nmap <buffer> b <Plug>(fern-action-new-file)
				nmap <buffer> B <Plug>(fern-action-new-dir)
				nmap <buffer> r <Plug>(fern-action-rename)
		
				nmap <buffer> d <Plug>(fern-action-trash)
				nmap <buffer> D <Plug>(fern-action-remove)
		
				nmap <buffer> dd <Plug>(fern-action-move)
				nmap <buffer> y <Plug>(fern-action-clipboard-copy)
				nmap <buffer> p <Plug>(fern-action-clipboard-paste)
		
				nmap <buffer> R
					\ <Plug>(fern-action-reload)
					\ <Plug>(fern-action-reload:cursor)
		
				nmap <buffer> / <Plug>(fern-action-grep=)
			endfunction
		
			augroup fern-custom
				autocmd! *
				autocmd FileType fern call s:init_fern()
			augroup END
		
			" アイコンに色をつける
			augroup my-glyph-palette
				autocmd! *
				autocmd FileType fern call glyph_palette#apply()
				autocmd FileType nerdtree,startify call glyph_palette#apply()
			augroup END
		
			" Error detected while processing function <lambda>1072[1]..<SNR>123_show[52]..<SNR>123_apply:
			" line		4:
			" E28: No such highlight group name: FernRootSymbolの解消
			" Gitに追跡されていない、かつ、長いファイル名のときに発生した
			hi FernRootSymbol ctermfg=white guifg=white ctermbg=NONE guibg=NONE
		]])
	end,
}
