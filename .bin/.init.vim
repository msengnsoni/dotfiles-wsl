" vim basic settings
" Vi互換の無効
set nocompatible

" ESCキーのキーマッピング
inoremap jk <ESC>

" shellの指定 
set shell=/bin/zsh

" 画面表示関連
set ruler
set showmode
set showcmd
set showmatch
set number
set laststatus=2
set virtualedit=onemore
set wrap
set linebreak
set cursorline
set wildmenu

" 検索関連
set hlsearch
set incsearch
set smartcase
set ignorecase

" タブ/インデント関連
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

" 文字コード関連
set fenc=utf-8
set enc=utf-8

" ビープ関連
set visualbell

" 作成ファイル関連
set noswapfile
set nobackup

" ファイル読込関連
set autoread
set hidden

" クリップボードへの登録
set clipboard=unnamed


call plug#begin()
Plug 'ntk148v/vim-horizon'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" if you don't set this option, this color might not correct
set termguicolors

colorscheme horizon

" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'horizon'

let NERDTreeShowHidden=1
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
