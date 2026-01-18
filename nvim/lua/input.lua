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
	vim.keymap.set("i", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
		callback(nil) -- キャンセル時は nil を渡す
	end, { buffer = buf, nowait = true })

	vim.keymap.set("i", "<CR>", function()
		-- バッファ（入力用バッファ）からテキストを取得
		--
		--   vim.api.nvim_buf_get_lines(buf, 1, -1, false)
		--
		--   buf          : 取得対象のバッファ番号（先に作成した入力ウィンドウのバッファ）
		--   1            : 開始行番号 (0‑based)。ここでは 1 を指定しているので、2 行目（プロンプト行を除く）から取得
		--   -1           : 終了行番号。-1 は「最後の行まで」を意味する
		--   false        : strict_indexing フラグ。false の場合は範囲外アクセスでもエラーにならず、実際に存在する行だけを返す
		--
		--  戻り値はテキスト行の配列（Lua table）で、プロンプト行（1 行目）は除外される。
		local lines = vim.api.nvim_buf_get_lines(buf, 1, -1, false)

		-- 空行を削除する
		if #lines > 0 and lines[#lines] == "" then
			table.remove(lines)
		end

		-- 配列 `lines` を改行文字で結合して、1 つの文字列にまとめる
		--
		--   table.concat(lines, "\n")
		--
		--   lines        : 先ほど取得したテキスト行の配列（例: {"echo hello", ""}）
		--   "\n"         : 区切り文字。各行を改行で結合することで、バッファ内にあった改行構造を再現
		--
		--  結果として `text` は「入力された全テキスト」を 1 行の文字列（または複数行になる場合もある）として保持
		local text = table.concat(lines, "\n")
		vim.api.nvim_win_close(win, true)
		callback(text)
	end, { buffer = buf, nowait = true })

	-- カーソルを入力行へ移動
	vim.api.nvim_win_set_cursor(win, { 2, 0 })
	vim.api.nvim_command("startinsert")
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
-- vim.keymap.set("n", "<C-i>", function()
-- 	create_centered_input_window("Command? ", 0.5, 0.3, function(txt)
-- 		if txt then
-- 			vim.cmd(txt)
-- 		end
-- 	end)
-- end, { noremap = true, silent = true })

-- ────────────────────────────────────────────────────────
-- ユーザーが <C-i> を押すと
--   1. create_centered_input_window() でプロンプトを表示
--   2. ユーザーが入力した文字列を、外部 API に送信
--   3. レスポンスの assistant.content を取得し、
--      そのまま現在バッファへ貼り付ける
-- ────────────────────────────────────────────────────────
vim.keymap.set("n", "<C-i>", function()
	create_centered_input_window(
		"なんでもきいてね！ ", -- プロンプト
		0.5, -- 横幅（%）
		0.3, -- 高さ（%）
		function(txt) -- コールバック
			if not txt then
				return
			end

			----------------------------------------------------
			-- 1️⃣ 送信する JSON ボディを作る
			----------------------------------------------------
			local payload = {
				model = "openai/gpt-oss-20b",
				messages = {
					{
						role = "user",
						content = txt
							.. "\n返答はコードのみで、マークダウンではなく、プレーンテキストで返してください。",
					},
				},
				temperature = 0.7,
				max_tokens = -1,
				stream = false,
			}

			-- Lua のテーブルを JSON にシリアライズ
			local json_body = vim.fn.json_encode(payload)

			----------------------------------------------------
			-- 2️⃣ curl コマンドを実行してレスポンスを取得
			----------------------------------------------------
			-- `curl` は標準出力に JSON を返すので、vim.fn.system() で取得
			local cmd = {
				"curl",
				"-s", -- 進捗表示を抑える
				"-H",
				"Content-Type: application/json",
				"-d",
				json_body,
				"http://localhost:1234/v1/chat/completions",
			}

			-- `system()` は文字列を返すので、改行等で整形
			local resp = vim.fn.system(cmd)

			----------------------------------------------------
			-- 3️⃣ JSON を Lua にデコードして content を取り出す
			----------------------------------------------------
			local ok, decoded = pcall(vim.json.decode, resp)
			if not ok or type(decoded) ~= "table" then
				vim.notify("❌ API 呼び出し失敗: " .. tostring(resp), vim.log.levels.ERROR)
				return
			end

			-- assistant.content が存在するか確認
			local content = nil
			for _, choice in ipairs(decoded.choices or {}) do
				if choice.message and choice.message.role == "assistant" then
					content = choice.message.content
					break
				end
			end

			if not content then
				vim.notify("❌ assistant.content が見つかりませんでした", vim.log.levels.ERROR)
				return
			end

			----------------------------------------------------
			-- 4️⃣ 取得したテキストを現在バッファへ貼り付ける
			----------------------------------------------------
			local lines = vim.split(content, "\n")
			-- 末尾に空行が入っていると改行だけの行が貼られるので除去
			if #lines > 0 and lines[#lines] == "" then
				table.remove(lines)
			end

			vim.api.nvim_put(lines, "l", true, false)
		end
	)
end, { noremap = true, silent = true })
