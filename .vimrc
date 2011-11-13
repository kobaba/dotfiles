"----------------------------------------------------------------
" Vundle
"----------------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""" on github
Bundle 'gmarik/vundle'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-surround'
Bundle 'thinca/vim-quickrun'
Bundle 'vim-scripts/vtreeexplorer'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'koron/chalice'
Bundle 'thinca/vim-ref'

""" on www.vim.org
Bundle 'yanktmp.vim'
Bundle 'errormarker.vim'
" sudo権限でファイルを保存する
Bundle 'sudo.vim'
" ディレクトリ内のファイルを再帰的に比較する
Bundle 'DirDiff.vim'

""" on other git repos

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
set formatoptions-=ro
set incsearch

"----------------------------------------------------------------
" ハイライト
"----------------------------------------------------------------
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
nmap <ESC><ESC> :nohlsearch<CR>

" indent-guides: インデントをハイライト
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_color_change_percent = 20
"let g:indent_guides_guide_size = 1

" errormarker.vim [Vimテクニックバイブル P.202]
let g:errormarker_errortext    = '!!'
let g:errormarker_warningtext  = '??'
let g:errormarker_errorgroup   = 'Error'
let g:errormarker_warninggroup = 'Todo'
"if has('win32') || has('win64')
"    let g:errormarker_erroricon   = expand('~/.vim/signs/err.bmp')
"    let g:errormarker_warningicon = expand('~/.vim/signs/warn.bmp')
"else
"    let g:errormarker_erroricon   = expand('~/.vim/signs/err.bmp')
"    let g:errormarker_warningicon = expand('~/.vim/signs/err.png')
"endif

"----------------------------------------------------------------
" Visualモード
"----------------------------------------------------------------
" ペーストしたテキストをVisualモードで選択する (Vimテクニックバイブル P.110)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" 行末以降, 文字のない箇所もカーソル移動可能に
set virtualedit=block


" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
"autocmd BufWritePre * :%s/\t/  /ge
" 最後にカーソルがあった位置まで移動 (Vimテクニックバイブル P.69)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" CTRL-hjklでウィンドウ移動
"nnoremap <C-j> ;<C-w>j
"nnoremap <C-k> ;<C-k>j
"nnoremap <C-l> ;<C-l>j
"nnoremap <C-h> ;<C-h>j

"----------------------------------------------------------------
" Yank
"----------------------------------------------------------------
" OSのクリップボードを使用する
set clipboard+=unnamed
" ヤンクした文字は、システムのクリップボードに入れる
set clipboard=unnamed
" ヤンクした文字列とカーソル位置の単語を置換する (Vimテクニックバイブル P.123)
nnoremap <silent> cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
" yanktmp
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>
if has("win32")
    let g:yanktmp_file = $TEMP . '/vimyanktmp'
endif

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

"----------------------------------------------------------------
" Template
"----------------------------------------------------------------
augroup templateload
    autocmd!
    autocmd BufNewFile *.php 0r ~/.vim/template/skeleton.php
    autocmd BufNewFile *.pl  0r ~/.vim/template/skeleton.pl
    autocmd BufNewFile *.pm  0r ~/.vim/template/skeleton.pm
augroup END

"----------------------------------------------------------------
" quickrun
"----------------------------------------------------------------
augroup QuickRunUnitTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.unit
  autocmd BufWinEnter,BufNewFile *.t set filetype=perl.unit
augroup END
let g:quickrun_config = {}
let g:quickrun_config['php.unit'] = {'command': 'phpunit'}
let g:quickrun_config['perl.unit'] = {'command': 'prove'}

"----------------------------------------------------------------
" Functions
"----------------------------------------------------------------
" URLエンコード, デコード [alice.vim] [Vimテクニックバイブル P.164]
" - TODO: 日本語だとうまくいかない
function s:URLEncode()
    let l:line = getline('.')
    let l:encoded = AL_urlencode(l:line)
    call setline('.', l:encoded)
endfunction
function s:URLDecode()
    let l:line = getline('.')
    let l:decoded = AL_urldecode(l:line)
    call setline('.', l:decoded)
endfunction
command! -nargs=0 -range URLEncode :<line1>,<line2>call <SID>URLEncode()
command! -nargs=0 -range URLDecode :<line1>,<line2>call <SID>URLDecode()

"----------------------------------------------------------------
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

"----------------------------------------------------------------
" NOTE:
" - カレントディレクトリを変更する (KaoriYa Patch, or cmdex.vim)
"   :CdCurrent
" - 全角<->半角 (KaoriYa Patch, or hz_ja.vim)
"   :Zenkaku :Hankaku
"----------------------------------------------------------------
" 参考サイト:
" - http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"----------------------------------------------------------------
