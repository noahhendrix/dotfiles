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
  Bundle 'kchmck/vim-coffee-script'

" ================
" Theming
" ================
  colorscheme desert

" ================
" File Handling
" ================
  set backupdir=~/.vimbackup//
  set directory=~/.vimswap//

  set encoding=utf-8
  set autoread          "Auto-reload files when changed on disk

  function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
  endfunction

  " Close Vim even if NERDTree is open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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
" Test stuff
" ================
  function! RunCurrentTest()
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
    if in_test_file
      call SetTestFile()

      if match(expand('%'), '\.feature$') != -1
        call SetTestRunner("!bin/cucumber")
        exec g:bjo_test_runner g:bjo_test_file
      elseif match(expand('%'), '_spec\.rb$') != -1
        call SetTestRunner("!bin/rspec")
        exec g:bjo_test_runner g:bjo_test_file
      else
        call SetTestRunner("!ruby -Itest")
        exec g:bjo_test_runner g:bjo_test_file
      endif
    else
      exec g:bjo_test_runner g:bjo_test_file
    endif
  endfunction

  function! SetTestRunner(runner)
    let g:bjo_test_runner=a:runner
  endfunction

  function! SetTestFile()
    let g:bjo_test_file=@%
  endfunction
" ================
" Line Behavior
" ================
  set nowrap
  set number
  set foldmethod=indent foldlevel=99
  set colorcolumn=81

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
  map <C-n> :NERDTreeToggle<CR>
  map <Leader>n :NERDTreeFocus<CR>
  nmap <Leader>v :vsp $MYVIMRC<CR>

  command! W w
