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
-- Ctrl + P で ファイル検索を開く(Functionは以下を参照)
vim.api.nvim_set_keymap("n", "<C-p>", ":lua SearchFzf()<CR>", {})
vim.api.nvim_set_keymap("n", "<C-f>", ":Files<CR>", {})
-- fgでGrepを行う
vim.api.nvim_set_keymap("n", "fg", ":RG<CR>", {})
-- ESC2回押しでハイライトを消す
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":noh<CR>", { noremap = true })
