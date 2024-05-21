-- Shift + J を押すと前のバッファに移動
vim.api.nvim_set_keymap("n", "<S-j>", ":bp<CR>", {})
-- Shift + K を押すと次のバッファに移動
vim.api.nvim_set_keymap("n", "<S-k>", ":bn<CR>", {})
-- <space>q を押すと現在のタブを閉じます
vim.api.nvim_set_keymap("n", "<space>q", ":bwipe<CR>", { silent = true })
-- fr を押すと置換するようにする
vim.api.nvim_set_keymap("n", "fr", ":%s/", {})
-- ESCでハイライトを消す
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true })
-- <space>w でpain間を移動する
vim.api.nvim_set_keymap("n", "<space>w", "<C-w>w", { noremap = true })
-- normalモードで;を:にマッピングする
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
-- react用のコメントアウト
vim.api.nvim_set_keymap("n", "<space>rc", ":s/</{\\/*</<CR>:s/$/*\\/}/<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>re", ":s/{\\/\\*//<CR>:s/\\*\\/}//<CR>", { noremap = true })

vim.api.nvim_set_keymap("i", "¥", "\\", {})
vim.api.nvim_set_keymap("c", "¥", "\\", {})
