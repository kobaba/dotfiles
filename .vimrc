"----------------------------------------------------------------
" Vundle
"----------------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" plugins
Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-quickrun'
Bundle 'vim-scripts/vtreeexplorer'

filetype plugin indent on

"----------------------------------------------------------------
" 基本設定
"----------------------------------------------------------------
colorscheme desert

set nobackup
set noswapfile
set hidden
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set showcmd
set showmode
set autoindent
"set smartindent
set nosmartindent     " 改行時の自動コメントアウトを無効
set formatoptions=rq  " 'r': Insertモード時は自動コメントアウトを有効に
set incsearch

"----------------------------------------------------------------
" quote from http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"----------------------------------------------------------------
" OSのクリップボードを使用する
set clipboard+=unnamed
"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
"autocmd BufWritePre * :%s/\t/  /ge

" CTRL-hjklでウィンドウ移動
"nnoremap <C-j> ;<C-w>j
"nnoremap <C-k> ;<C-k>j
"nnoremap <C-l> ;<C-l>j
"nnoremap <C-h> ;<C-h>j

"----------------------------------------------------------------
" Status Line
"----------------------------------------------------------------
set laststatus=2
set ruler

"----------------------------------------------------------------
" Apperance
"----------------------------------------------------------------
set showmatch
set number
"set list
set cursorline

"----------------------------------------------------------------
" pathgen.vim
"----------------------------------------------------------------
" pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
"filetype off
"" pathogen.vimによってbundle配下のpluginをpathに加える
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
"set helpfile=$VIMRUNTIME/doc/help.txt
"" ファイルタイプ判定をon
"filetype plugin on

"----------------------------------------------------------------
" surround.vim
"----------------------------------------------------------------
" s, ssで選択範囲を指定文字でくくる
"nmap s <Plug>Ysurround
"nmap ss <Plug>Yssurround

"----------------------------------------------------------------
" VTreeExplorer
"----------------------------------------------------------------
let g:treeExplVertical=1
let g:treeExplWinSize=30
