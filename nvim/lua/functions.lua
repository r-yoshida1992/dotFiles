-- Gitのルートディレクトリを取得する
function GetGitRoot()
	local result = vim.fn.systemlist("git rev-parse --show-toplevel")
	if vim.v.shell_error == 0 then
		return result[1]
	else
		return vim.fn.expand("%:p:h")
	end
end
