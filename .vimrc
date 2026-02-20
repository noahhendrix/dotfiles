set nocompatible               " be iMproved
set hidden                     " switch buffers w/out saving
set updatetime=250             " delay before idle event triggered
set shortmess+=c               " reduce noisy completion messages

" ================
" Plugins
" ================
  " To Install
  " curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  call plug#begin('~/.vim/plugged')

  " Editor Featuers
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'dockyard/vim-easydir'
  Plug 'tpope/vim-vinegar'
  Plug 'mbbill/undotree'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'

  " Code Features
  Plug 'Raimondi/delimitMate'
  Plug 'dense-analysis/ale'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'othree/html5.vim'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'tpope/vim-endwise'

  " Git Features
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  call plug#end()

" ================
" Theming
" ================
  syntax on
  set termguicolors
  set background=dark
  let g:tokyonight_style = 'night'
  colorscheme tokyonight

" ================
" File Handling
" ================
  if !has('nvim')
    set backupdir=~/.vim/backup/
    set directory=~/.vim/swap/
    set viminfo+=n~/.vim/viminfo
  endif
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
        call delete(old_name)
        redraw!
    endif
  endfunction

" ================
" Code stuff
" ================
  filetype plugin indent on

  set expandtab shiftwidth=2 tabstop=2 softtabstop=2
  set backspace=indent,eol,start

  " Fix for slow Ruby syntax highlighting:
  " http://stackoverflow.com/questions/16902317
  set regexpengine=1

  " Color columns after 100
  let &colorcolumn=join(range(101, 999), ",")
  highlight ColorColumn ctermbg=235 guibg=#2c2d27

  " Syntax Checking
  let g:ale_linters = {
        \  'javascript': ['eslint'],
        \  'typescript': ['eslint'],
        \}

  let g:ale_fixers = {
        \  'javascript': ['eslint'],
        \  'typescript': ['eslint'],
        \  'css': ['prettier'],
        \  'json': ['prettier'],
        \  'markdown': ['prettier'],
        \}

  let g:ale_fix_on_save = 1

  " jBuilder syntax highlighting
  au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" ================
" Line Behavior
" ================
  set nowrap
  set relativenumber number
  set signcolumn=yes                                " shows left gutter
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
