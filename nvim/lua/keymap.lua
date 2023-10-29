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
