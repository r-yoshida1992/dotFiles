-- 行番号の表示
vim.o.number = true
-- タブの代わりにスペースを使う
vim.o.expandtab = true
-- タブ文字を表示する際の幅
vim.o.tabstop = 2
-- タブを自動で入力する
vim.o.smartindent = true
-- 自動で入力されるタブの幅
vim.o.shiftwidth = 2
-- タブキー押下時の幅
vim.o.softtabstop = 2
-- タブを切り替えた時に自動でディレクトリを移動
vim.o.autochdir = true
-- 文字コードの設定
vim.o.encoding = "utf-8"
-- クリップボードの設定
vim.o.clipboard = "unnamed,unnamedplus"
-- eコマンド等でTabキーを押すとパスを保管する(文字列のリスト) : この場合まず最長一致文字列まで補完し、2回目以降は一つづつ試す
vim.o.wildmode = "longest,full"
-- カーソルの移動や入力の変更を検知する間隔を300ミリ秒に設定
vim.o.updatetime = 300
-- ファイルタイプの検出、プラグインの有効化、および自動インデントを設定する。
vim.cmd("filetype plugin indent on")
-- タブの有効化
vim.g["airline#extensions#tabline#enabled"] = 1
-- タブの番号を表示
vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
-- rustのコードを保存時にフォーマットする
vim.g.rustfmt_autosave = 1
-- Prettierを使用して自動フォーマットを行う
-- vim.g.prettier#autoformat = 1
-- tsxファイルの保存時にPrettierを実行するautocmdの設定
vim.cmd("autocmd BufWritePost *.tsx Prettier")
-- tsファイルの保存時にPrettierを実行するautocmdの設定
vim.cmd("autocmd BufWritePost *.ts Prettier")

-- ショートカットの設定
-- Ctrl + J を押すと前のタブに移動します
vim.api.nvim_set_keymap("n", "<C-j>", "<Plug>AirlineSelectPrevTab", {})
-- Ctrl + K を押すと次のタブに移動します
vim.api.nvim_set_keymap("n", "<C-k>", "<Plug>AirlineSelectNextTab", {})
-- gd を押すとカーソル下の定義箇所にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
-- gy を押すとカーソル下の型定義にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
-- gi を押すとカーソル下の実装箇所にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true })
-- gr を押すとカーソル下の参照箇所にジャンプします（coc.nvimプラグイン）
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })

-- f を押すとフォーマットをかけます
vim.api.nvim_set_keymap("n", "f", ":Prettier<CR>", {})

-- functions
-- git管理されていれば:GFiles、そうでなければ:Filesを実行する
function SearchFzf()
  local is_git = vim.fn.system('git status')
  if vim.v.shell_error ~= 0 then
    vim.cmd("Files")
  else
    vim.cmd("GFiles")
  end
end

-- Ctrl + P で ファイル検索を開く(Functionは以下を参照)
vim.api.nvim_set_keymap("n", "<C-p>", ":lua SearchFzf()<CR>", {})

-- プラグインの設定
require('packer').startup(function()
  -- プラグマネージャーの初期化を開始する
  use 'vim-airline/vim-airline'             -- vim-airlineプラグインを追加する（状態行のカスタマイズ）
  use 'vim-airline/vim-airline-themes'      -- vim-airline-themesプラグインを追加する（状態行のテーマ）
  use { 'junegunn/fzf', run = function() vim.fn["fzf#install"]() end }  -- fzfプラグインを追加する（高速なファジーファインダー）
  use 'junegunn/fzf.vim'                    -- fzf.vimプラグインを追加する（fzfのVimインターフェース）
  use 'rust-lang/rust.vim'                  -- rust.vimプラグインを追加する（Rust言語のサポート）
  use { 'neoclide/coc.nvim', branch = 'release' }  -- coc.nvimプラグインを追加する（補完やコード分析のためのVimプラグイン）
  use { 'neoclide/coc-java', branch = 'release' } -- coc-javaの導入
  use 'lewis6991/gitsigns.nvim'             -- gitsigns.nvimプラグインを追加する（Gitの変更を表示する）
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production', branch = 'release/0.x' }  -- vim-prettierプラグインを追加する（PrettierのVimインテグレーション）
end)

-- 常にサインカラムを表示するようにする。そうしないと、診断情報が表示されたり解決されたりするたびにテキストがシフトしてしまいます。
if vim.fn.has("patch-8.1.1564") then
  vim.o.signcolumn = "number"
else
  vim.o.signcolumn = "yes"
end

-- <CR>で最初の補完項目を自動選択し、coc.nvimに改行時のフォーマットを通知する（<cr>は他のVimプラグインで再マッピングされる可能性があるため、無音で表現される）
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-g>u<CR>' . coc#on_enter()", { expr = true })

