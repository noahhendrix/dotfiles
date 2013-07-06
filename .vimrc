set nocompatible               " be iMproved

" ================
" Vundle
" ================
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'
  Bundle 'kien/ctrlp.vim'
  Bundle 'mileszs/ack.vim'
  Bundle 'scrooloose/nerdtree'
  Bundle 'tpope/vim-fugitive'
  Bundle 'Shutnik/jshint2.vim'

" ================
" File Handling
" ================
  set backupdir=~/.vimbackup//
  set directory=~/.vimswap//

  set encoding=utf-8
  set autoread          "Auto-reload files when changed on disk

" ================
" Code stuff
" ================
  syntax on
  filetype plugin indent on

  set expandtab shiftwidth=2 tabstop=2 softtabstop=2
  set backspace=indent,eol,start

  " JSHint on save
  autocmd! BufWritePost * if &filetype == "javascript" | silent JSHint | endif

" ================
" Line behavior
" ================
  set nowrap
  set number
  set foldmethod=indent foldlevel=99

  " Highlight lines over 80 characters
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/

  " Highlight trailing whitespace
  highlight TrailingSpace ctermbg=red ctermfg=white guibg=#592929
  match TrailingSpace /\s\+$/

  " Remove trailing whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

" ================
" Splits
" ================
  set splitbelow splitright

" ================
" Searching
" ================
  set ignorecase smartcase  " Case-insensitive searching (unless capital letter)
  set incsearch             " Incremental searching

" ================
" Shortcuts
" ================
  map <Leader>j !python -m json.tool<CR>
  map <Leader><Leader>n :NERDTreeFind<CR>
  nmap <Leader>v :vsp $MYVIMRC<CR>