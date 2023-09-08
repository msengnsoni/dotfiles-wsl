" vim basic settings
set mouse=a
" vi互換の無効
set nocompatible
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

" vim-plug
call plug#begin()
if exists('g:vscode')
    " Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
else
    Plug 'ntk148v/vim-horizon'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'easymotion/vim-easymotion'
    " Plug 'vim-easymotion/vim-easymotion'
endif
call plug#end()

if exists('g:vscode')
    " VSCode extension
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')

        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction

    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
    augroup END
else
    " ordinary Neovim
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
    nnoremap <C-n> :NERDTreeToggle<CR>
endif