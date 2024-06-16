noremap j gj
noremap k gk

set clipboard+=unnamedplus

" When formatting text, recognize numbered lists.
set formatoptions+=n

" search
nnoremap <silent> <C-L> :nohlsearch<CR>
set ignorecase
set smartcase

" splitting
set splitbelow
set splitright

" indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
autocmd Filetype go setlocal noexpandtab
autocmd Filetype lua setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype nix setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd Filetype objc setlocal commentstring=/*%s*/

let mapleader = " "
