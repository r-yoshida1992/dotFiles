" 行番号の表示
set number
" タブの代わりにスペースを使う
set expandtab
" タブ文字を表示する際の幅
set tabstop=2
" タブを自動で入力する
set smartindent
" 自動で入力されるタブの幅
set shiftwidth=2
" タブキー押下時の幅
set softtabstop=2
" タブを切り替えた時に自動でディレクトリを移動
set autochdir
" 文字コードの設定
set encoding=utf-8
" クリップボードの設定
set clipboard+=unnamed,unnamedplus
" eコマンド等でTabキーを押すとパスを保管する(文字列のリスト) : この場合まず最長一致文字列まで補完し、2回目以降は一つづつ試す
set wildmode=longest,full
" カーソルの移動や入力の変更を検知する間隔を300ミリ秒に設定
set updatetime=300
" ファイルタイプの検出、プラグインの有効化、および自動インデントを設定する。
filetype plugin indent on
" タブの有効化
let g:airline#extensions#tabline#enabled = 1
" タブの番号を表示
let g:airline#extensions#tabline#buffer_idx_mode = 1
" rustのコードを保存時にフォーマットする
let g:rustfmt_autosave = 1
" Prettierを使用して自動フォーマットを行う
let g:prettier#autoformat = 1
" tsxファイルの保存時にPrettierを実行するautocmdの設定
autocmd BufWritePost *.tsx Prettier
" tsファイルの保存時にPrettierを実行するautocmdの設定
autocmd BufWritePost *.ts Prettier

" ショートカットの設定
" Ctrl + J を押すと前のタブに移動します
nmap <C-j> <Plug>AirlineSelectPrevTab
" Ctrl + K を押すと次のタブに移動します
nmap <C-k> <Plug>AirlineSelectNextTab
" gd を押すとカーソル下の定義箇所にジャンプします（coc.nvimプラグイン）
nmap <silent> gd <Plug>(coc-definition)
" gy を押すとカーソル下の型定義にジャンプします（coc.nvimプラグイン）
nmap <silent> gy <Plug>(coc-type-definition)
" gi を押すとカーソル下の実装箇所にジャンプします（coc.nvimプラグイン）
nmap <silent> gi <Plug>(coc-implementation)
" gr を押すとカーソル下の参照箇所にジャンプします（coc.nvimプラグイン）
nmap <silent> gr <Plug>(coc-references)
" Ctrl + P で ファイル検索を開く(Functionは以下を参照)
nnoremap <C-p> :call SearchFzf()<CR>

" プラグインの設定
call plug#begin()                              " プラグマネージャーの初期化を開始する
    Plug 'vim-airline/vim-airline'             " vim-airlineプラグインを追加する（状態行のカスタマイズ）
    Plug 'vim-airline/vim-airline-themes'      " vim-airline-themesプラグインを追加する（状態行のテーマ）
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   " fzfプラグインを追加する（高速なファジーファインダー）
    Plug 'junegunn/fzf.vim'                    " fzf.vimプラグインを追加する（fzfのVimインターフェース）
    Plug 'rust-lang/rust.vim'                  " rust.vimプラグインを追加する（Rust言語のサポート）
    Plug 'neoclide/coc.nvim', {'branch': 'release'}   " coc.nvimプラグインを追加する（補完やコード分析のためのVimプラグイン）
    Plug 'lewis6991/gitsigns.nvim'             " gitsigns.nvimプラグインを追加する（Gitの変更を表示する）
    Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile --production', 'branch': 'release/0.x'}   " vim-prettierプラグインを追加する（PrettierのVimインテグレーション）
call plug#end()                                " プラグマネージャーの初期化を終了する
" functions

" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! SearchFzf()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun

" Rustプラグイン
" 常にサインカラムを表示するようにする。そうしないと、診断情報が表示されたり解決されたりするたびにテキストがシフトしてしまいます。
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" <CR>で最初の補完項目を自動選択し、coc.nvimに改行時のフォーマットを通知する（<cr>は他のVimプラグインで再マッピングされる可能性があるため、無音で表現される）
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

