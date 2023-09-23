-- 行番号の表示;
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
-- helpの日本語化
vim.o.langmenu = "ja_JP.UTF-8"
vim.o.helplang = "ja"
