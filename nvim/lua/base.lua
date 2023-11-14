local setvar = vim.api.nvim_set_var

-- 不要なデフォルトプラグインを無効化する
-- 参考: https://zenn.dev/kawarimidoll/articles/8172a4c29a6653
setvar("did_install_default_menus", 1)
setvar("did_install_syntax_menu", 1)
setvar("did_indent_on", 1)
setvar("loaded_man", 1)
setvar("loaded_matchit", 1)
setvar("loaded_matchparen", 1)
setvar("loaded_tarPlugin", 1)
setvar("loaded_tutor_mode_plugin", 1)
setvar("skip_loading_mswin", 1)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[
  augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
  augroup END
]])
