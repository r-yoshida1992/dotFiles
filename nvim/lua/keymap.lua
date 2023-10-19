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
vim.api.nvim_set_keymap("n", "<space>c", "gcc", {})
-- mpでMarkdownをプレビューする
vim.api.nvim_set_keymap("n", "mp", ":MarkdownPreview<CR>", {})
-- ESC2回押しでハイライトを消す
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":noh<CR>", { noremap = true })
