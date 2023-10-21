-- colorの設定
vim.cmd("colorscheme nightfox")

vim.cmd([[  
  augroup LuaAutoFmt
    autocmd!
    autocmd BufWritePre *.lua :lua require('stylua-nvim').format_file()
  augroup END
]])
