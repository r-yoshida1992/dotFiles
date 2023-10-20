local opt = vim.opt
-- 文字コードをUTF-8にする
opt.encoding = "utf-8"
-- ヘルプの言語を日本語にする
opt.helplang = "ja"
-- 行数表示部分の幅を固定する
opt.numberwidth = 6
-- ステータスラインを常に表示する
opt.ruler = true
-- インデント幅を2に設定
opt.shiftwidth = 2
-- タブ文字の幅を2に設定
opt.tabstop = 2
-- タブ文字をスペースに展開するオプションを有効にする
opt.expandtab = true
-- 自動インデントを有効にする
opt.autoindent = true
-- スマートインデントを有効にする
opt.smartindent = true
-- コマンドラインのコマンドを表示する
opt.showcmd = true
-- ステータスラインを常に表示
opt.laststatus = 2
-- マッチした括弧をハイライト表示し、1秒間表示する
opt.showmatch.matchtime = 1
-- バックスペースキーで特定の位置で削除可能な文字を指定
opt.backspace = "indent,eol,start"
-- 仮想編集モードを有効にし、カーソルを行の末尾以降に移動できるようにする
opt.virtualedit = "onemore"
-- スワップファイルを無効にする
opt.swapfile = false
-- クリップボードとして+レジスタを使用
opt.clipboard = "unnamedplus"
-- コマンドラインの補完メニューを有効にする
opt.wildmenu = true
-- コマンドラインヒストリを最大5000エントリまで保存
opt.history = 5000
-- テキストの折り返しを無効にする
opt.wrap = false
-- インクリメンタルサーチを有効にする
opt.incsearch = true
-- ハイライト検索を有効にする
opt.hlsearch = true
-- 検索時に大文字と小文字を区別せずに検索
opt.ignorecase = true
-- 検索パターンに大文字が含まれる場合に区別して検索
opt.smartcase = true
-- タブ文字、半角スペース、行末の文字を可視化する
vim.opt.list = true
-- 可視化した文字の設定
vim.opt.listchars:append({ tab = '^ ', space = '·', eol = '↩︎' })
-- Global Status Line を有効にする
-- 画面をスプリットした時に Status LineはSplitされないようにする
opt.laststatus = 3

vim.cmd([[
  augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
  augroup END

  " 拡張子がmdxの時は、*.mdとして扱う
  au BufNewFile,BufRead *.mdx set filetype=markdown

  " luaのformatter
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]])
