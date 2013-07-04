set nocompatible               " be iMproved

" ================
" Vundle
" ================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'

" ================
" File Handling
" ================
set backupdir=~/.vimbackup//
set directory=~/.vimswap//

" ================
" Code stuff
" ================
syntax on
filetype plugin indent on

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" ================
" Line behavior
" ================
set nowrap
set colorcolumn=0
set number

" Highlight lines over 80 characters
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

highlight TrailingSpace ctermbg=red ctermfg=white guibg=#592929
match TrailingSpace /\s\+$/

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" ================
" Splits
" ================
set splitbelow
set splitright

" ================
" Searching
" ================
set ignorecase smartcase  " Case-insensitive searching (unless capital letter)

" ================
" Shortcuts
" ================
map <Leader>j !python -m json.tool<CR>
