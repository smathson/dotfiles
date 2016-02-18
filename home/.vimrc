set shell=/bin/bash
set nocompatible

" ==================================================
"   Setup vundle and plugins
" ==================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Vundle itself
Bundle 'gmarik/Vundle.vim'

" Language plugins
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'pangloss/vim-javascript'
Bundle 'groenewege/vim-less'
Bundle 'elzr/vim-json'

" Don't do concealing for JSON
let g:vim_json_syntax_conceal = 0

" Syntax checking
Bundle 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['html'] }

" Dynamically set up JS linters based on which configs exist locally
function! JsCheckers()
  let checkers = []
  if findfile('.eslintrc', '.;') != ''
    call add(checkers, 'eslint')
  endif
  if findfile('.jshintrc', '.;') != ''
    call add(checkers, 'jshint')
  endif
  if findfile('.jscsrc', '.;') != ''
    call add(checkers, 'jscs')
  endif
  return checkers
endfunction

autocmd FileType javascript let g:syntastic_javascript_checkers = JsCheckers()

" Editing sugar
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/upAndDown'

" Indenting
Bundle 'vim-scripts/IndentAnything'

" Git integration
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" Fast buffer switching
Bundle 'sjbach/lusty'
let g:LustyJugglerDefaultMappings = 0
let g:LustyJugglerSuppressRubyWarning = 1
nmap <c-b> :LustyJuggler<cr>
map <c-tab> <C-W>w

" Close buffer without closing window
Bundle 'rbgrouleff/bclose.vim'
map <leader>w :Bclose<cr>

" CtrlP for fuzzy file search
Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode     = 0
let g:ctrlp_match_window_bottom   = 1       " Set CtrlP window at bottom of screen
let g:ctrlp_match_window_reversed = 0       " Swap listing of files from top to bottom
let g:ctrlp_map                   = '<c-t>' " Rebind CtrlP to ctrl-t
let g:ctrlp_max_files             = 10000   " Set the max files
nmap <leader>b :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command  = ['.git/', 'cd %s && git ls-files -c -o --exclude-standard']

" NERDTree for when you need a file browser
Bundle 'scrooloose/nerdtree'
nmap <leader>p :NERDTreeToggle<cr>          " Toggle NERDTree
let NERDTreeShowHidden=1

" ACK plugin for searching in files
Bundle 'mileszs/ack.vim'

" Awesome statusline with custom zenburn colorscheme
Bundle 'smathson/vim-powerline'
let g:Powerline_cache_enabled = 0
let g:Powerline_symbols = 'compatible'
let g:Powerline_stl_path_style = 'relative'
let g:Powerline_colorscheme = 'zenburn'
set nosmd   " Don't show mode in status line

" Matchit for file recognition
runtime macros/matchit.vim
filetype plugin on

" Disable netrw history
let g:netrw_dirhistmax=0

" Code folding
set foldmethod=syntax
set foldlevel=99
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" ==================================================
"   Display settings
" ==================================================
colorscheme Tomorrow-Night-Eighties

" General
syntax enable
set encoding=utf-8
set timeoutlen=250
set autoread
set nobackup
set noswapfile
set nowritebackup
set vb
set hidden
set laststatus=2
set number

" Whitespace
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent

" List chars
set list
set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Clear search pattern with return when back in command mode
nnoremap <CR> :noh<CR><CR>

" Visual
vmap > >gv
vmap < <gv

" Access to system clipboard
set clipboard=unnamed


" ==================================================
"   Key mapping
" ==================================================

" Indenting
map <leader>I gg=G``<cr>  " Reindent entire file

" Map F1 to Esc because my aim sucks sometimes
map   <F1> <Esc>
imap  <F1> <Esc>

" Dont Be Lazy
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Final Vundle requirement
filetype plugin indent on
