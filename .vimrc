set nocompatible               " be iMproved
let mapleader=","

" ================
" Vundle
" ================
  " To Install
  " git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'
  Bundle 'kien/ctrlp.vim'
  Bundle 'scrooloose/syntastic'
  Bundle 'pangloss/vim-javascript'
  Bundle 'dockyard/vim-easydir'
  Bundle 'tpope/vim-vinegar'
  Bundle 'mbbill/undotree'
  Bundle 'tpope/vim-dispatch'

" ================
" Theming
" ================
  colorscheme desert

" ================
" File Handling
" ================
  set backupdir=~/.vim/backup/
  set directory=~/.vim/swap/
  set viminfo+=n~/.vim/viminfo
  set encoding=utf-8
  set autoread                      " Auto-reload files when changed on disk
  set splitbelow splitright         " More natural splitting
  set statusline=%f%m%=%r           " FILENAME [RO]
  set laststatus=2                  " Always show statusline

  function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
  endfunction

" ================
" Code stuff
" ================
  syntax on
  filetype plugin indent on

  set expandtab shiftwidth=2 tabstop=2 softtabstop=2
  set backspace=indent,eol,start

" ================
" Line Behavior
" ================
  set nowrap
  set relativenumber number
  set timeout timeoutlen=1000 ttimeoutlen=100       " Fix slow O inserts
  set list listchars=tab:»·,trail:·                 " Show trailing whitespace as dots

  autocmd BufWritePre * :%s/\s\+$//e                " Remove trailing whitespace on save

" ================
" Searching
" ================
  set ignorecase smartcase  " Case-insensitive searching (unless capital letter)
  set incsearch             " Incremental searching
  set hlsearch              " Highlight results

  " Tab-completion using longest common sub-string
  set wildmenu wildmode=longest:full,list:full,list:longest wildchar=<TAB>

  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|tmp)$'

  " The Silver Searcher
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  endif

" ================
" Shortcuts
" ================
  map <Leader>q :cclose<CR>
  map <Leader>v :vsp $MYVIMRC<CR>

  command! W w
  command! Q q

