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
  Bundle 'bling/vim-airline'
  Bundle 'christoomey/vim-tmux-navigator'
  Bundle 'jelera/vim-javascript-syntax'
  Bundle 'ZoomWin'
  Bundle 'dockyard/vim-easydir'
  Bundle 'tpope/vim-vinegar'

" ================
" Theming
" ================
  colorscheme desert

  let g:airline_powerline_fonts=1
  let g:airline_detect_modified=0
  let g:airline_right_sep=''
  let g:airline_section_x=''
  let g:airline_section_y=''
  let g:airline_section_z=''

  set laststatus=2                  " Makes airline work w/o splitting

" ================
" File Handling
" ================
  set backupdir=~/.vim/backup/
  set directory=~/.vim/swap/
  set viminfo+=n~/.vim/viminfo
  set encoding=utf-8
  set autoread                      " Auto-reload files when changed on disk
  set splitbelow splitright         " More natural splitting
  let g:netrw_liststyle=3           " Use tree listing style

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

  set expandtab shiftwidth=4 tabstop=4 softtabstop=4
  set backspace=indent,eol,start

" ================
" Line Behavior
" ================
  set nowrap
  set relativenumber number
  set foldmethod=indent foldlevel=99
  set colorcolumn=81
  set timeout timeoutlen=1000 ttimeoutlen=100       " Fix slow O inserts

  " Highlight trailing whitespace
  highlight TrailingSpace ctermbg=red ctermfg=white guibg=#592929
  match TrailingSpace /\s\+$/

  " Remove trailing whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

" ================
" Searching
" ================
  set ignorecase smartcase  " Case-insensitive searching (unless capital letter)
  set incsearch             " Incremental searching

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
  map <Leader><Leader> :ZoomWin<CR>
  map <Leader>v :vsp $MYVIMRC<CR>

  command! W w
  command! Q q

