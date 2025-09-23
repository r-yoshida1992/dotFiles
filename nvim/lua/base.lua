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

-- 半角になってしまうマルチバイト文字を全角にする
local fn = vim.fn
fn.setcellwidths({
	{ 0x203B, 0x203B, 2 }, -- ※
	{ 0x2460, 0x2460, 2 }, -- ①
	{ 0x2461, 0x2461, 2 }, -- ②
	{ 0x2462, 0x2462, 2 }, -- ③
	{ 0x2463, 0x2463, 2 }, -- ④
	{ 0x2464, 0x2464, 2 }, -- ⑤
	{ 0x2465, 0x2465, 2 }, -- ⑥
	{ 0x2466, 0x2466, 2 }, -- ⑦
	{ 0x2467, 0x2467, 2 }, -- ⑧
	{ 0x2468, 0x2468, 2 }, -- ⑨
	{ 0x2469, 0x2469, 2 }, -- ⑩
	{ 0x246A, 0x246A, 2 }, -- ⑪
	{ 0x246B, 0x246B, 2 }, -- ⑫
	{ 0x246C, 0x246C, 2 }, -- ⑬
	{ 0x246D, 0x246D, 2 }, -- ⑭
	{ 0x246E, 0x246E, 2 }, -- ⑮
	{ 0x246F, 0x246F, 2 }, -- ⑯
	{ 0x2470, 0x2470, 2 }, -- ⑰
	{ 0x2471, 0x2471, 2 }, -- ⑱
	{ 0x2472, 0x2472, 2 }, -- ⑲
	{ 0x2473, 0x2473, 2 }, -- ⑳
	{ 0x25CF, 0x25CF, 2 }, -- ●
	{ 0x2192, 0x2192, 2 }, -- →
	{ 0x2193, 0x2193, 2 }, -- ↓
	{ 0x2190, 0x2190, 2 }, -- ←
	{ 0x2191, 0x2191, 2 }, -- ↑
	{ 0x21E8, 0x21E8, 2 }, -- ⇨
	{ 0x21E7, 0x21E7, 2 }, -- ⇧
	{ 0x21E9, 0x21E9, 2 }, -- ⇩
	{ 0x21E6, 0x21E6, 2 }, -- ⇦
	{ 0x2196, 0x2196, 2 }, -- ↖︎
	{ 0x2197, 0x2197, 2 }, -- ↗︎
	{ 0x2198, 0x2198, 2 }, -- ↘︎
	{ 0x2199, 0x2199, 2 }, -- ↙︎
})
