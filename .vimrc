noremap j gj
noremap k gk

syntax enable

set autoindent
set smartindent

set autoread

set backspace=indent,eol,start

set clipboard=unnamed

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set formatoptions+=jn

set hlsearch
nnoremap <silent> <C-L> :nohlsearch<CR>
set ignorecase
set incsearch
set smartcase

set laststatus=2
set ruler
set scrolloff=0
set noshowcmd
set wildmenu

set nojoinspaces

set splitbelow
set splitright

set ttimeout
set ttimeoutlen=100

autocmd Filetype go setlocal noexpandtab

autocmd Filetype nix setlocal shiftwidth=2 softtabstop=2 tabstop=2

autocmd Filetype objc setlocal commentstring=/*%s*/

let mapleader = " "
