local function create_centered_input_window(prompt, width_pct, height_pct, callback)
	local win_height = math.floor(vim.o.lines * (height_pct or 0.3))
	local win_width = math.floor(vim.o.columns * (width_pct or 0.5))

	local row = math.floor((vim.o.lines - win_height) / 2)
	local col = math.floor((vim.o.columns - win_width) / 2)

	-- バッファ作成（空白行を入れておく）
	local buf = vim.api.nvim_create_buf(false, true) -- unlisted & scratch

	-- ←ここで改行ごとに別々の要素を渡す
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { prompt .. " ", "", "" }) -- プロンプト + 空行2行

	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "single",
		focusable = true,
		noautocmd = true,
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	-- キーマップ：Esc=キャンセル、<CR>=確定
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
		callback(nil) -- キャンセル時は nil を渡す
	end, { buffer = buf, nowait = true })

	vim.keymap.set("n", "<CR>", function()
		local lines = vim.api.nvim_buf_get_lines(buf, 1, -1, false)
		local text = table.concat(lines, "\n")
		vim.api.nvim_win_close(win, true)
		callback(text)
	end, { buffer = buf, nowait = true })

	-- カーソルを入力行へ移動
	vim.api.nvim_win_set_cursor(win, { 2, 0 })
end

-- コマンド例
vim.api.nvim_create_user_command("CenterInput", function(opts)
	create_centered_input_window("Please type:", 0.6, 0.4, function(txt)
		if txt then
			vim.notify("入力: " .. txt, vim.log.levels.INFO)
		else
			vim.notify("キャンセル", vim.log.levels.WARN)
		end
	end)
end, {})

-- キーマップ例
vim.keymap.set("n", "<C-i>", function(opts)
	create_centered_input_window("Command? ", 0.5, 0.3, function(txt)
		if txt then
			vim.cmd(txt)
		end
	end)
end, { noremap = true, silent = true })
