-- Ctrl + J を押すと前のタブに移動します
vim.api.nvim_set_keymap("n", "<C-j>", "<Plug>AirlineSelectPrevTab", {})
-- Ctrl + K を押すと次のタブに移動します
vim.api.nvim_set_keymap("n", "<C-k>", "<Plug>AirlineSelectNextTab", {})
-- <space>q を押すと現在のタブを閉じます
vim.api.nvim_set_keymap("n", "<space>q", ":bwipe<CR>", { silent = true })
-- fe を押すとサイドにファイルツリーを表示します
vim.api.nvim_set_keymap("n", "fe", ":Fern " .. GetGitRoot() .. " -reveal=% -drawer<CR>", {})
-- fr を押すと置換するようにする
vim.api.nvim_set_keymap("n", "fr", ":%s/", {})
-- コメントアウト
vim.api.nvim_set_keymap("n", "<space>c", "gcc", {})
-- mpでMarkdownをプレビューする
vim.api.nvim_set_keymap("n", "mp", ":MarkdownPreview<CR>", {})
-- ESCでハイライトを消す
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true })
-- wn でpain間を移動する
vim.api.nvim_set_keymap("n", "wn", "<C-w>w", { noremap = true })

-- Java
local P = {}
keymaps = P
vim.g.mapleader = " "
local key_map = function(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

function P.map_java_keys(bufnr)
	local spring_boot_run = "mvn spring-boot:run -Dspring-boot.run.profiles=local"
	local command = ':lua require("toggleterm").exec("' .. spring_boot_run .. '")<CR>'
	key_map("n", "<leader>sr", command)
	key_map("n", "<leader>oi", ':lua require("jdtls").organize_imports()<CR>')
	key_map("n", "<leader>jc", ':lua require("jdtls").compile("incremental")')
end

return P
