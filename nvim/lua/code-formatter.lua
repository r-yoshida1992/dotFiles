-- f を押すとフォーマットをかけます
vim.api.nvim_set_keymap("n", "ff", ":lua CodeFormat()<CR>", {})

function CodeFormat()
	-- 拡張子がts,tsx,js,jsxの場合はprettierをかける
	local file_extension = vim.fn.expand("%:e")
	if file_extension == "ts" or file_extension == "tsx" or file_extension == "js" or file_extension == "jsx" then
		vim.cmd("Prettier")
	elseif file_extension == "lua" then
		vim.cmd("lua require('stylua-nvim').format_file()")
	end
end
