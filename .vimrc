"----------------------------------------------------------------
" Vundle
"----------------------------------------------------------------
let $GIT_SSL_NO_VERIFY = 'true'
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
let g:vundle_default_git_proto='git'
call vundle#rc()

""" GitHub
Bundle 'gmarik/vundle'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'thinca/vim-quickrun'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'koron/chalice'
Bundle 'thinca/vim-ref'
"Bundle 'thinca/vim-javascript'
Bundle 'tsaleh/vim-matchit.git'
Bundle 'vim-scripts/yanktmp.vim'
Bundle 'vim-scripts/sudo.vim'
Bundle 'vim-scripts/vtreeexplorer'
Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim'

""" www.vim.org
"Bundle 'errormarker.vim'
"Bundle 'JavaScript.vim'
"Bundle 'DirDiff.vim'

""" Other Git Repos

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
set nosmartindent     " 改行時の自動コメントアウトを無効
set formatoptions=rq  " 'r': Insertモード時は自動コメントアウトを有効に
autocmd VimEnter,WinEnter * set formatoptions-=o
set incsearch

" 自動折り返し
"set formatoptions+=mM
"set textwidth=120

"" Apperance
set showmatch
set number
"set list
"set cursorline

set splitbelow
set splitright

syntax on
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings+=utf-8,iso-2022-jp,euc-jp,ucs2le,ucs-2,cp932

"----------------------------------------------------------------
" 検索
"----------------------------------------------------------------
set ignorecase
set smartcase
set hlsearch
set wrapscan

"----------------------------------------------------------------
" ステータスライン
"----------------------------------------------------------------
set laststatus=2
set ruler
"set statusline=

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

" タブをハイライト
highlight Tabspace ctermbg=red guibg=red
match Tabspace /\t\+/
autocmd WinEnter * match Tabspace /\t\+/

" indent-guides: インデントをハイライト
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_color_change_percent = 20
"let g:indent_guides_guide_size = 1

" errormarker.vim [Vimテクニックバイブル P.202]
let g:errormarker_errortext    = '!!'
let g:errormarker_warningtext  = '??'
let g:errormarker_errorgroup   = 'Error'
let g:errormarker_warninggroup = 'Todo'
"let g:errormarker_erroricon   = expand('~/.vim/signs/err.bmp')
"let g:errormarker_warningicon = expand('~/.vim/signs/err.png')

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
let g:yanktmp_file = $HOME . '/vimyanktmp'

"----------------------------------------------------------------
" Tab
"----------------------------------------------------------------
set showtabline=1
map th :tabfirst<CR>
map tj :tabprev<CR>
map tk :tabnext<CR>
map tl :tablast<CR>
map tt :tabedit<CR>
map tn :tabnext<CR>
map tm :tabm<CR>

nmap <C-n> :tabnew<cr>
imap <C-n> <ESC>:tabnew<cr>

"----------------------------------------------------------------
" neocomplecache
"----------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_snippets_dir = '~/.vim/snippets'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'php'   : $DOCVIM.'/dict/php53.dict',
    \ 'perl'  : $DOCVIM.'/dict/perl.dict',
    \ 'ruby'  : $DOCVIM.'/dict/ruby.dict',
    \ 'javascript' : $DOCVIM.'/dict/javascript.dict',
    \ 'c'     : $DOCVIM.'/dict/c.dict',
    \ 'html'  : $DOCVIM.'/dict/javascript.dict' }

"----------------------------------------------------------------
" ctags
"----------------------------------------------------------------
autocmd FileType php        :set tags+=~/.tags/php.tags
autocmd FileType c          :set tags+=~/.tags/c.tags
autocmd FileType perl,cgi   :set tags+=~/.tags/perl.tags

"----------------------------------------------------------------
" surround.vim
"  note:
"   vmode + S" .. 選択範囲を"で囲む
"   ss"        .. カーソル行を"で囲む
"   sw"        .. カーソル位置の単語を"で囲む
"----------------------------------------------------------------
" s, ssで選択範囲を指定文字でくくる
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround

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
" PHPDoc Comment
"----------------------------------------------------------------
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

"----------------------------------------------------------------
" quickrun : https://github.com/thinca/vim-quickrun/blob/master/doc/quickrun.jax
"----------------------------------------------------------------
let g:quickrun_config = {}
let b:quickrun_config = {'outputter/buffer/split': 10}

augroup QuickRunUnitTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *[tT]est.php set filetype=php.unit
  autocmd BufWinEnter,BufNewFile *.t set filetype=perl.unit
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.spec
  "autocmd BufWinEnter,BufNewFile *.js set filetype=js.unit
augroup END
let g:quickrun_config['php.unit'] = {'command': 'phpunit'}
let g:quickrun_config['perl.unit'] = {'command': 'perl'}
"let g:quickrun_config['perl.unit'] = {'command': 'prove'}
let g:quickrun_config['ruby.spec'] = {'command': 'rspec', 'cmdopt': '-c'}
"let g:quickrun_config['js'] = {'command': 'node'}

"----------------------------------------------------------------
" Compiler
"----------------------------------------------------------------
autocmd FileType perl,cgi :compiler perl
autocmd BufWritePost *.php !php -l %

"----------------------------------------------------------------
" HTML & CSS
"----------------------------------------------------------------
" インデントの無効化 https://sites.google.com/site/vimdocja/filetype-html#:filetype-indent-off
"autocmd FileType html :set noautoindent noindent nosmartindent indentexpr=
autocmd FileType html :set tabstop=4 shiftwidth=4 softtabstop=4

"----------------------------------------------------------------
" Functions
"----------------------------------------------------------------
" URLエンコード, デコード [alice.vim] [Vimテクニックバイブル P.164] - TODO: 日本語だとうまくいかない
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
" Encoding
"----------------------------------------------------------------
if filereadable(expand('~/.vim/local/recognize_charcode.vim'))
    source ~/.vim/local/recognize_charcode.vim
endif

"----------------------------------------------------------------
" Load Local Setting
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
"
" 参考サイト:
" - http://sites.google.com/site/vimdocja/
" - http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"----------------------------------------------------------------
