-- Shift + J を押すと前のバッファに移動
vim.api.nvim_set_keymap("n", "<S-j>", ":bp<CR>", {})
-- Shift + K を押すと次のバッファに移動
vim.api.nvim_set_keymap("n", "<S-k>", ":bn<CR>", {})
-- <space>q を押すと現在のタブを閉じます
vim.api.nvim_set_keymap("n", "<space>q", ":bwipe<CR>", { silent = true })
-- fr を押すとファイル内置換するようにする
vim.api.nvim_set_keymap("n", "fr", ":%s/", {})
-- ESCでハイライトを消す
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true })
-- <space>w でpain間を移動する
vim.api.nvim_set_keymap("n", "<space>w", "<C-w>w", { noremap = true })
-- normalモードで;を:にマッピングする
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
-- backspaceを入力可能にする
vim.api.nvim_set_keymap("i", "¥", "\\", {})
vim.api.nvim_set_keymap("c", "¥", "\\", {})
-- 現在のパスを出力する
vim.api.nvim_set_keymap("n", "<leader>gr", ":r !pwd<CR>", { noremap = true, silent = true })
-- Git Grepを実行しその結果を出力する
vim.api.nvim_set_keymap("n", "<leader>gg", ":lua GitGrepInput()<CR>", { noremap = true, silent = true })
-- スネークケースとキャメルケースを相互変換する
vim.api.nvim_set_keymap("v", "<leader>sc", ":lua ToggleCase()<CR>", { noremap = true, silent = true })
