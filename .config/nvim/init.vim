let mapleader=","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab             " converts tabs to white space
set shiftwidth=4            " width for autoindents
set number relativenumber   " add relative line numbers
set wildmode=longest,list   " get bash-like tab completions
set cursorline              " highlight current line
set lazyredraw              " redraw only when needed
set noswapfile              " Remove swap file usage
set splitbelow splitright   " Splits open at the bottom and right

syntax enable
filetype on
" filetype indent on          " load filetype file from ./indent/{filetype}
filetype plugin on          " load settings for filetype from ./after/ftplugin/

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Run shellcheck
map <leader>s :!clear && shellcheck %<CR>

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Movement
" Easier splits navigation by Ctrl + hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

call plug#begin('~/.nvim/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Color scheme used in the GIFs!
Plug 'arcticicestudio/nord-vim'

" Programming
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'plytophogy/vim-virtualenv'
Plug 'pixelneo/vim-python-docstring'
Plug 'dense-analysis/ale'

" Look and feel
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'

call plug#end()


" Toggle NERDtreeview
nnoremap <silent> <Space> :NERDTreeToggle <CR>

" Toggle tagbar
" nmap <F8> :TagbarToggle<CR>

" Set working dir to currently opened file
autocmd BufEnter * silent! lcd %:p:h

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Programming
" Hit % on if to jump to else
runtime macros/matchit.vim

" Move text under cursor to new line
nnoremap <F2> i<CR><Esc>

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

"Python
let b:ale_linters = {'python': ['flake8', 'mypy']}
let b:ale_fixers = {'python': ['black', 'isort']}
