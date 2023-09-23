-- Gitのルートディレクトリを取得する
function GetGitRoot()
	local result = vim.fn.systemlist("git rev-parse --show-toplevel")
	if vim.v.shell_error == 0 then
		return result[1]
	else
		return vim.fn.expand("%:p:h")
	end
end

-- git管理されていれば:GFiles、そうでなければ:Filesを実行する
function SearchFzf()
	local is_git = vim.fn.system("git status")
	if vim.v.shell_error ~= 0 then
		vim.cmd("Files")
	else
		vim.cmd("GFiles")
	end
end

-- ripgrepを使ってプロジェクト内のファイルを検索する
function FZGrep(query, fullscreen)
	local git_root = GetGitRoot()
	local command_fmt = "rg --column --line-number --no-heading --color=always --smart-case -- %s "
		.. git_root
		.. " || true"
	local initial_command = string.format(command_fmt, vim.fn.shellescape(query))
	local reload_command = string.format(command_fmt, "{q}")
	local spec = { options = { "--phony", "--query", query, "--bind", "change:reload:" .. reload_command } }
	vim.fn["fzf#vim#grep"](initial_command, 1, vim.fn["fzf#vim#with_preview"](spec), fullscreen)
end

