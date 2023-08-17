set nocompatible "more vim-like, less vi-like
call plug#begin()
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'hashivim/vim-terraform', {'for':'terraform'}
call plug#end()

set backspace=2
"reload vimrc on F5, spelling on F6
nnoremap <F5> :so $MYVIMRC<cr>
map <F6> :setlocal spell! spelllang=en_us<CR>
"colors
syntax enable
set background=dark
set guifont=Fira\ Mono\ 11
set t_Co=256 "256 colors in terminal
"set cc=80

set number "line numberings
set smartindent "indent on new line

"tab options
set tabstop=4
set shiftwidth=4
"set expandtab
filetype indent on "filetype-specific indents
set linebreak

set mouse=a
set wildmode=longest,list,full "completion mode
set wildmenu "command-line completion
set path+=** "add current directory to path

set splitright splitbelow "vsplit/split: always put new windows below/right
" new vsplit
map <C-w>N :vnew<CR>
"window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"search: ignore case, except when caps are used
set ignorecase
set smartcase
set incsearch "search as characters are entered
set hlsearch "highlight matches

" Reopen the last edited position in files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"statusline
let g:airline_theme='minimalist'
let g:airline_extensions = ['branch','bufferline']
"custom keymaps
let mapleader=","
inoremap jj <esc>
nnoremap bn :bnext<cr>
nnoremap bN :bprevious<cr>
nnoremap <F4> :! %<cr>
nnoremap <F2> :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeToggle<cr>
nnoremap bD :set background=dark<cr>
nnoremap bL :set background=light<cr>
tnoremap <ESC> <C-w>:q!<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>r :so $MYVIMRC<cr>
nnoremap <leader>D :Gdiff<cr>
nnoremap <leader>B :G blame<cr>
nnoremap <leader>gf :edit %:h/<cfile><CR>

"file runners
"if in python, get python console with f12 and run file with f4
autocmd FileType python nnoremap <buffer> <F12> :let $VIM_DIR=expand('%:p:h')<CR>:let $FILE_NAME_WITH_EXT=expand('%:t')<CR>:terminal<CR>cd "$VIM_DIR"<CR>export PS1="\e[0;34m \W${_BOLD}\$ \e[m"<CR>clear<CR>FILE_NAME=${FILE_NAME_WITH_EXT::-4}<CR>python $FILE_NAME_WITH_EXT<CR>
"autocmd FileType python nnoremap <F12> :!python <cr>
autocmd FileType python map <buffer> <F4> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F4> <esc>:w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
autocmd FileType ruby map <buffer> <F4> :w<CR>:exec '!clear;ruby' shellescape(@%, 1)<CR>
autocmd FileType ruby imap <buffer> <F4> <esc>:w<CR>:exec '!clear;ruby' shellescape(@%, 1)<CR>
autocmd FileType shell map <buffer> <F4> :w<CR>:exec '!clear;bash' shellescape(@%, 1)<CR>
autocmd FileType shell imap <buffer> <F4> <esc>:w<CR>:exec '!clear;bash' shellescape(@%, 1)<CR>
autocmd FileType html map <buffer> <F4> :w<CR>:exec '!clear;firefox' shellescape(@%, 1)<CR>
autocmd FileType html imap <buffer> <F4> <esc>:w<CR>:exec '!clear;firefox' shellescape(@%, 1)<CR>
"run rust, go, c files with rs, g, c runner scripts in $PATH
autocmd FileType rust map <buffer> <F4> :w<CR>:exec '!rs' shellescape(@%, 1)<CR>
autocmd FileType rust imap <buffer> <F4> <esc>:w<CR>:exec '!rs' shellescape(@%, 1)<CR>
autocmd FileType go map <buffer> <F4> :w<CR>:exec '!g' shellescape(@%, 1)<CR>
autocmd FileType go imap <buffer> <F4> <esc>:w<CR>:exec '!g' shellescape(@%, 1)<CR>
autocmd FileType c map <buffer> <F4> :w<CR>:exec '!c' shellescape(@%, 1)<CR>
autocmd FileType c imap <buffer> <F4> <esc>:w<CR>:exec '!c' shellescape(@%, 1)<CR>

"formatters
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType vala setlocal syntax=vala
    autocmd FileType yaml setlocal tabstop=2
    autocmd FileType yaml setlocal expandtab
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd FileType yaml setlocal expandtab
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END

