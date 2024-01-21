set mouse=a
set hlsearch                " highlight search 
set incsearch               " incremental search

syntax on
filetype plugin indent on
" show existing tab with 6 spaces width
set tabstop=6
" when indenting with '>', use 6 spaces width
set shiftwidth=6
" On pressing tab, insert 6 spaces
set expandtab
set modeline
set background=dark

set clipboard+=unnamedplus
set encoding=UTF-8
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set smartindent
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
" Map the leader key to a comma.
let mapleader = ','
" set spell                 " enable spell check (may need to download language package)
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.



" autocmd VimEnter * NvimTreeOpen 

" autocmd TabNew * NvimTreeOpen
" autocmd TabNew * lua require("sidebar-nvim").open()

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
