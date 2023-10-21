-- autocmd
vim.cmd([[  
  augroup LuaAutoFmt
    autocmd!
    " luaのフォーマット
    autocmd BufWritePre *.lua :lua require('stylua-nvim').format_file()
  augroup END
]])
