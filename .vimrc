set nocompatible               " be iMproved

" ================
" Plugins
" ================
  " To Install
  " curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  call plug#begin('~/.vim/plugged')

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'dockyard/vim-easydir'
  Plug 'tpope/vim-vinegar'
  Plug 'mbbill/undotree'
  Plug 'tpope/vim-surround'
  Plug 'Raimondi/delimitMate'
  Plug 'tpope/vim-repeat'
  Plug 'w0rp/ale'

  call plug#end()

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

  " Fix for slow Ruby syntax highlighting:
  " http://stackoverflow.com/questions/16902317
  set regexpengine=1

  " Color columns after 80
  let &colorcolumn=join(range(101, 999), ",")
  highlight ColorColumn ctermbg=235 guibg=#2c2d27

  " Syntax Checking
  let g:validator_javascript_checkers = ['npm run eslint']

  " jBuilder syntax highlighting
  au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" ================
" Line Behavior
" ================
  set nowrap
  set relativenumber number
  set timeout timeoutlen=1000 ttimeoutlen=100       " Fix slow O inserts
  set list listchars=tab:»·,trail:·                 " Show trailing whitespace

  autocmd BufWritePre * :%s/\s\+$//e                " Remove trailing whitespace on save

" ================
" Searching
" ================
  set ignorecase smartcase  " Case-insensitive searching (unless capital letter)
  set incsearch             " Incremental searching
  set hlsearch              " Highlight results

  " Tab-completion using longest common sub-string
  set wildmenu wildmode=longest:full,list:full,list:longest wildchar=<TAB>

  " The Silver Searcher
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
  endif

" ================
" Shortcuts
" ================
  let mapleader=","

  map <Leader>q :cclose<CR>
  map <Leader>v :vsp $MYVIMRC<CR>

  " FZF.vim
  nnoremap <c-p> :Files<cr>
  nnoremap <c-b> :Buffers<cr>

  command! W w
  command! Q q
  command! Vsp vsp
  command! Grep grep
  command! Cnf cnf
  command! Cn cn
