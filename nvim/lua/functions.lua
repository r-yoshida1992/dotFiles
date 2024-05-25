-- Gitのルートディレクトリを取得する
function GetGitRoot()
	local result = vim.fn.systemlist("git rev-parse --show-toplevel")
	if vim.v.shell_error == 0 then
		return result[1]
	else
		return vim.fn.expand("%:p:h")
	end
end

-- Git Grepを実行しその結果を出力する
function GitGrepInput()
	-- 入力を受け取るプロンプトを表示
	local input = vim.fn.input("Git grep: ")
	-- 入力が空でない場合、git grepコマンドを実行
	if input ~= "" then
		-- コマンドの出力を現在のバッファに追加
		vim.cmd('silent! execute "r !git grep -n ' .. input .. '"')
	end
end

-- キャメルケースをスネークケースに変換する関数
local function camel_to_snake(camel_str)
	return camel_str
		:gsub("(%u)", function(c)
			return "_" .. c:lower()
		end)
		:gsub("^_", "") -- 先頭にアンダースコアが付いた場合削除
end

-- スネークケースをキャメルケースに変換する関数
local function snake_to_camel(snake_str)
	return snake_str:lower():gsub("_(%a)", function(match)
		return match:upper()
	end)
end

-- 文字列がスネークケースかどうかを判定する関数
local function is_snake_case(str)
	return str:match("_[a-zA-Z]") ~= nil
end

-- トグル関数
function ToggleCase()
	-- ビジュアルモードで選択したテキストの開始位置と終了位置を取得
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line = start_pos[2]
	local end_line = end_pos[2]
	local start_col = start_pos[3]
	local end_col = end_pos[3]

	-- 選択範囲のすべての行を取得
	local lines = vim.fn.getline(start_line, end_line)

	-- 選択範囲内のテキストをキャメルケースまたはスネークケースに変換
	for i, line in ipairs(lines) do
		if i == 1 then
			-- 最初の行
			if start_line == end_line then
				-- 単一行の場合
				local selection = line:sub(start_col, end_col)
				if is_snake_case(selection) then
					lines[i] = line:sub(1, start_col - 1) .. snake_to_camel(selection) .. line:sub(end_col + 1)
				else
					lines[i] = line:sub(1, start_col - 1) .. camel_to_snake(selection) .. line:sub(end_col + 1)
				end
			else
				-- 複数行の最初の行
				local selection = line:sub(start_col)
				if is_snake_case(selection) then
					lines[i] = line:sub(1, start_col - 1) .. snake_to_camel(selection)
				else
					lines[i] = line:sub(1, start_col - 1) .. camel_to_snake(selection)
				end
			end
		elseif i == #lines then
			-- 最後の行
			local selection = line:sub(1, end_col)
			if is_snake_case(selection) then
				lines[i] = snake_to_camel(selection) .. line:sub(end_col + 1)
			else
				lines[i] = camel_to_snake(selection) .. line:sub(end_col + 1)
			end
		else
			-- 中間の行
			if is_snake_case(line) then
				lines[i] = snake_to_camel(line)
			else
				lines[i] = camel_to_snake(line)
			end
		end
	end

	-- 変換されたテキストをバッファに書き戻す
	vim.fn.setline(start_line, lines)
end
