local opt = vim.opt
-- 行番号の表示
opt.number = true
-- 行番号を相対的な位置で表示する
opt.relativenumber = true
-- タブキー押下時の幅
opt.softtabstop = 2
-- 文字コードをUTF-8にする
opt.encoding = "utf-8"
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
-- クリップボードの設定
opt.clipboard = "unnamed,unnamedplus"
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
-- Global Status Line を有効にする
-- 画面をスプリットした時に Status LineはSplitされないようにする
opt.laststatus = 3
-- タブを切り替えた時に自動でディレクトリを移動
opt.autochdir = true
-- eコマンド等でTabキーを押すとパスを保管する(文字列のリスト) : この場合まず最長一致文字列まで補完し、2回目以降は一つづつ試す
opt.wildmode = "longest,full"
-- カーソルの移動や入力の変更を検知する間隔を300ミリ秒に設定
opt.updatetime = 300
-- helpの日本語化
opt.langmenu = "ja_JP.UTF-8"
opt.helplang = "ja"
-- colorschemeを読み込むための設定
opt.termguicolors = true
