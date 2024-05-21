return {
	"mattn/vim-findroot",
	event = { "VeryLazy" },
	config = function()
		vim.cmd([[
      let g:findroot_not_for_subdir = 0
      let g:findroot_patterns = [
      \  '.git/',
      \]
		]])
	end,
}
