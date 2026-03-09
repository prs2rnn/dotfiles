" ~/.config/nvim/init.vim (config file for convenient work)
" if you use vim, create ~/.vimrc instead
" https://www.jakewiesler.com/blog/getting-started-with-vim

set mouse=a " enable mouse
set encoding=utf-8
set number
set relativenumber
set scrolloff=7
set wrap
set linebreak
set ruler  " prompt in right down corner
set ignorecase  " ignore case when search with /...
syntax on
set noswapfile

" case insensitive search unless capital letters are used
set ignorecase
set smartcase

" hide status mode couse lightline is installed
set noshowmode

" block for good tabulation in python as PEP-8 and so on
set tabstop=2
set softtabstop=2  " 2 spaces in 1 tab
set shiftwidth=2
set expandtab  " set tabs as spaces
set autoindent
set fileformat=unix
filetype indent on  " load filetype-specific indent files
set smartindent

autocmd FileType python,sass setlocal shiftwidth=4 softtabstop=4 expandtab

" automatically strip trailing spaces on save (*.py if for python only)
autocmd BufWritePre * :%s/\s\+$//e

" show spaces
" set list
" set lcs+=space:·

" function for trim final new lines on save
function TrimEndLines()
    let save_cursor = getpos(".")
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

autocmd BufWritePre * call TrimEndLines()

" enable the system clipboard (wl-clipboard-Wayland or xclip-X11 required)
set clipboard+=unnamedplus

" enable colorcolumn
autocmd FileType python,javascript,typescript,html setlocal cc=80


call plug#begin()
" nerdtree instead of netrw
Plug 'preservim/nerdtree'

" Lightline
Plug 'itchyny/lightline.vim'

" vim-fugitive - for git support, no config is required
Plug 'tpope/vim-fugitive'

" gitsigns - for display modifications in git
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

" nerdtree bindings (:Nerdtree), ? for help inside.
" shift+i for hidden. m for mode. dirs will be created automatically.
" shift+r for update files. I can use /search and other keybindings inside.
" t to newtab, s to split when open
nnoremap <C-e> :NERDTreeToggle<CR>
" open NerdTree on the file you’re editing to quickly perform operations on it
nnoremap <C-f> :NERDTreeFind<CR>
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

" block for terminal settings (type 'exit' + press 'enter' to close)
tnoremap <ESC> <C-\><C-n>

" Block for custom keybindings in vim
let mapleader = ","
nnoremap <Space>/ :noh<CR>
nnoremap d "_d
vnoremap d "_d

" keymap for managing buffer
map gn :bn<cr>
map gp :bp<cr>
map gw :bd<cr>

" open files with no extension as txt
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=txt | endif
