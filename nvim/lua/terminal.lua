local keyset = vim.api.nvim_set_keymap
local user_command = vim.api.nvim_create_user_command

-- TerminalをVSCodeのように現在のウィンドウの下に開く
vim.api.nvim_create_autocmd("TermOpen", {
	command = "startinsert",
})

-- ターミナルが開いた時に行番号を非表示にする
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.o.number = false
		vim.o.relativenumber = false
	end,
})

-- 常にインサートモードでTerminalを開く（水平分割）
user_command("T", "sp | wincmd j | resize 20 | terminal <args>", { nargs = "*" })
keyset("n", "T", ":T <cr>", { noremap = true })

-- 常にインサートモードでTerminalを開く（垂直分割(右)）
user_command("TS", "rightbelow vs | wincmd j | resize 100 | terminal <args>", { nargs = "*" })
keyset("n", "TS", ":TS <cr>", { noremap = true })

-- インサートモードからの離脱をspace + qにマッピング
keyset("t", "<Space>q", "<C-\\><C-n>", { silent = true })
