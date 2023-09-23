-- Ctrl + J を押すと前のタブに移動します
vim.api.nvim_set_keymap("n", "<C-j>", "<Plug>AirlineSelectPrevTab", {})
-- Ctrl + K を押すと次のタブに移動します
vim.api.nvim_set_keymap("n", "<C-k>", "<Plug>AirlineSelectNextTab", {})
-- Ctrl + w を押すと現在のタブを閉じます
vim.api.nvim_set_keymap("n", "<C-w>", "<Plug>AirlineClose", {})
-- gd を押すとカーソル下の定義箇所にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
-- gy を押すとカーソル下の型定義にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
-- gi を押すとカーソル下の実装箇所にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
-- gr を押すとカーソル下の参照箇所にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
-- f を押すとフォーマットをかけます
vim.api.nvim_set_keymap("n", "ff", ":Prettier<CR>", {})
-- ff を押すとサイドにファイルツリーを表示します
vim.api.nvim_set_keymap("n", "<leader>f", ":Fern " .. GetGitRoot() .. " -reveal=% -drawer<CR>", {})
vim.api.nvim_set_keymap("n", "q", ":q<CR>", {})
-- fr を押すと置換するようにする
vim.api.nvim_set_keymap("n", "fr", ":%s/", {})
vim.api.nvim_set_keymap("n", "<C-/>", ":s/^/--/<CR>", {})
vim.api.nvim_set_keymap("v", "<C-/>", ":s/^/--/<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<Plug>(coc-codeaction-selected)", {})

-- mdvでMarkdownをプレビューする
vim.api.nvim_set_keymap("n", "mp", ":MarkdownPreview<CR>", {})

-- Ctrl + P で ファイル検索を開く(Functionは以下を参照)
vim.api.nvim_set_keymap("n", "<C-p>", ":lua SearchFzf()<CR>", {})
vim.api.nvim_set_keymap("n", "<C-f>", ":Files<CR>", {})
vim.api.nvim_buf_set_keymap(0, "n", "<leader>f", '<cmd>lua require("stylua-nvim").format_file()<CR>', { noremap = true, silent = true})
-- <CR>で最初の補完項目を自動選択し、coc.nvimに改行時のフォーマットを通知する（<cr>は他のVimプラグインで再マッピングされる可能性があるため、無音で表現される）
vim.api.nvim_set_keymap(
	"i",
	"<CR>",
	"pumvisible() ? coc#_select_confirm() : '<C-g>u<CR>' . coc#on_enter()",
	{ expr = true }
)
vim.api.nvim_set_keymap("n", "fg", ":RG<CR>", {})
-- Shift + 左右矢印でウィンドウを移動する
vim.api.nvim_set_keymap("n", "<S-Left>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>l", { noremap = true })
-- ESC2回押しでハイライトを消す
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":noh<CR>", { noremap = true })
-- ヒントを表示
vim.api.nvim_set_keymap("n", "<space>h", ':<C-u>call CocAction("doHover")<cr>', { silent = true })
-- airlineのタブを閉じる
vim.api.nvim_set_keymap("n", "<space>q", ":bwipe<CR>", { silent = true })
