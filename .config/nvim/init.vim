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

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

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


" Rust
" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

