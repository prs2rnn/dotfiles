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
set list
set lcs+=space:·

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

" section for vim-plug-plugin manager for vim
call plug#begin()
" theme
" Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/joshdick/onedark.vim.git'

" Telescope requires plenary to function
Plug 'nvim-lua/plenary.nvim'
" The main Telescope plugin
Plug 'nvim-telescope/telescope.nvim'
" An optional plugin recommended by Telescope docs
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

" nerdtree instead of netrw
Plug 'preservim/nerdtree'

" Lightline
Plug 'itchyny/lightline.vim'

" vim-fugitive - for git support, no config is required
Plug 'tpope/vim-fugitive'

" gitsigns - for display modifications in git
Plug 'lewis6991/gitsigns.nvim'

" nvim-lspconfig-official LSP support from neovim, required to run LSP
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'  " the main
Plug 'hrsh7th/cmp-nvim-lsp'  " dependency of nvim-cmp
Plug 'L3MON4D3/LuaSnip'  " autocomplete for snippets
Plug 'saadparwaiz1/cmp_luasnip'  " snippet-completion source, recommended

" Multicursor (ctrl+n, ctrl+up/down for selection, shift+arrows-select chars,
" []-next or previous cursor)
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" gcc, gc, gcap for commenting
Plug 'https://github.com/tpope/vim-commentary.git'

" ctags - install it first: pacman -S ctags
Plug 'https://github.com/preservim/tagbar.git'

" for frontend
Plug 'mattn/emmet-vim'
Plug 'https://github.com/gregsexton/MatchTag.git'

call plug#end()

" turn on theme
color onedark
highlight Normal guibg=NONE

" Block for custom keybindings in vim
let mapleader = ","
nnoremap <Space>/ :noh<CR>
nnoremap d "_d
vnoremap d "_d

" keymap for managing buffer
map gn :bn<cr>
map gp :bp<cr>
map gw :bd<cr>

" disable keys
" for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"   exec 'noremap' key '<Nop>'
"   exec 'inoremap' key '<Nop>'
"   exec 'cnoremap' key '<Nop>'
" endfor

" convenient .py execution current file in normal and insert modes
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType python map <buffer> <leader>b :w<CR>:exec '!black' shellescape(@%, 1)<CR>
autocmd FileType python nnoremap <leader>i :PyrightOrganizeImports<CR>

" autocmd FileType html map <buffer> <leader>b :w<CR>:exec '!tidy -m' shellescape(@%, 1)<CR>

autocmd FileType javascript map <buffer> <F5> :w<CR>:exec '!node' shellescape(@%, 1)<CR>
autocmd FileType javascript imap <buffer> <F5> <esc>:w<CR>:exec '!node' shellescape(@%, 1)<CR>
autocmd FileType javascript map <buffer> <leader>i :w<CR>:exec '!import-sort --write' shellescape(@%, 1)<CR>

autocmd FileType javascript,json,scss,css,markdown,html,typescript,yaml map <buffer> <leader>b :w<CR>:exec '!prettier --write' shellescape(@%, 1)<CR>

" open files with no extension as txt
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set syntax=txt | endif

" call telescope.lua config file
lua require('plug')

" Telescope bindings
nnoremap <leader>f <cmd>Telescope find_files<CR>
nnoremap <leader>g <cmd>Telescope live_grep<CR>

" White colors for LSP messages in code
set termguicolors
hi DiagnosticError guifg=White
hi DiagnosticWarn  guifg=White
hi DiagnosticInfo  guifg=White
hi DiagnosticHint  guifg=White

" netrw file explrer settings (try :sexplore)
let g:netrw_liststyle = 3  " tree instead of plain view
" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'
" this helps you avoid the move files error.
let g:netrw_keepdir = 0
" change the copy command. mostly to enable recursive copy of directories.
" let g:netrw_localcopydircmd = 'cp -r'
" nnoremap <C-E> :Explore<CR>
" navigation
" function! NetrwMapping()
"   nmap <buffer> <C-E> :bd<CR>
" endfunction
" augroup netrw_mapping
"   autocmd!
"   autocmd filetype netrw call NetrwMapping()
" augroup END

" nerdtree bindings (:Nerdtree), ? for help inside.
" shift+i for hidden. m for mode. dirs will be created automatically.
" shift+r for update files. I can use /search and other keybindings inside.
" t to newtab, s to split when open
nnoremap <C-e> :NERDTreeToggle<CR>
" open NerdTree on the file you’re editing to quickly perform operations on it
nnoremap <C-f> :NERDTreeFind<CR>
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" block for terminal settings (type 'exit' + press 'enter' to close)
tnoremap <ESC> <C-\><C-n>

" ctags bind
nmap <F8> :TagbarToggle<CR>

" Enable emmet plugin just for html/css
" ,, to trigger emmet; html:5; ol[type="A"]#customer>li*10>{same $}
let g:user_emmet_install_global = 0
autocmd FileType html,css,sass,scss EmmetInstall
let g:user_emmet_leader_key=','

" completeion for CSS
filetype plugin on
set omnifunc=syntaxcomplete#Complete
inoremap <C-X> <C-X><C-O>

" turn on tag referrence by ctrl+%
runtime macros/matchit.vim

" zsh aliases support in vim shell
set shellcmdflag=-ic
