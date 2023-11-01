return {
	"mattn/vim-findroot",
	event = { "VimEnter" },
	config = function()
		vim.cmd([[
			let g:findroot_not_for_subdir = 0
			let g:findroot_patterns = [
			\  '.git/',
			\  '.gitignore',
			\]
		]])
	end,
}
