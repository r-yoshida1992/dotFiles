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
-- vim.cmd("autocmd BufWritePost *.tsx Prettier")
-- tsファイルの保存時にPrettierを実行するautocmdの設定
-- vim.cmd("autocmd BufWritePost *.ts Prettier")
vim.g["fern#renderer"] = "nerdfont"
vim.g["fern#default_hidden"] = 1
-- 大文字小文字を区別せずに検索するようにする
-- vim.o.ignorecase = true
-- save時にrsファイルだった場合、rustfmtを実行する
vim.cmd([[
  augroup RustFmt
    autocmd!
    autocmd BufWritePost *.rs RustFmt
  augroup END
]])

vim.cmd([[
  augroup ReactFiletypes
    autocmd!
    autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
    autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
  augroup END
]])

-- ショートカットの設定



-- functions

vim.cmd("source $VIMRUNTIME/delmenu.vim")
vim.cmd("source $VIMRUNTIME/menu.vim")

vim.g["findroot_patterns"] = { ".git", ".svn", ".hg", ".project", ".root", "_darcs", ".bzr", ".fslckout", "_FOSSIL_" }
vim.g["findroot_not_for_subdir"] = 0

vim.cmd("command! -nargs=* -bang RG lua FZGrep(<q-args>, <bang>0)")

