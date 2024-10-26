-- Set leader key
vim.g.mapleader = ","

-- Install vim-plug if not installed
local plug_path = vim.fn.stdpath('config') .. '/autoload/plug.vim'
if not vim.loop.fs_stat(plug_path) then
    print("Downloading junegunn/vim-plug to manage plugins...")
    vim.fn.system({
        'curl',
        '-fLo',
        plug_path,
        '--create-dirs',
        'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    })
    vim.api.nvim_command("autocmd VimEnter * PlugInstall | source $MYVIMRC")
end

-- General Settings
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = "longest,list"
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.shortmess:append("c")

-- Key Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Spell-check toggle
map("n", "<leader>o", ":setlocal spell! spelllang=en_us<CR>", opts)

-- Run shellcheck
map("n", "<leader>s", ":!clear && shellcheck %<CR>", opts)

-- Easier splits navigation
map("n", "<C-J>", "<C-W><C-J>", opts)
map("n", "<C-K>", "<C-W><C-K>", opts)
map("n", "<C-L>", "<C-W><C-L>", opts)
map("n", "<C-H>", "<C-W><C-H>", opts)

-- Plugin configuration
vim.cmd([[
call plug#begin('~/.nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'

Plug 'plytophogy/vim-virtualenv',  { 'for': 'python' }
Plug 'pixelneo/vim-python-docstring', { 'for': 'python' }
Plug 'dense-analysis/ale', { 'for': 'python' }

Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }

call plug#end()
]])

-- NERDTree toggle
map("n", "<Space>", ":NERDTreeToggle<CR>", opts)

-- Set working directory to current file's directory
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "silent! lcd %:p:h"
})

-- Delete trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

-- Clipboard mappings
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+yg_', opts)
map("n", "<leader>y", '"+y', opts)
map("n", "<leader>p", '"+p', opts)
map("n", "<leader>P", '"+P', opts)
map("v", "<leader>p", '"+p', opts)
map("v", "<leader>P", '"+P', opts)

-- Matchit plugin for jumping between 'if' and 'else'
vim.cmd("runtime macros/matchit.vim")

-- Move text to a new line
map("n", "<F2>", "i<CR><Esc>", opts)

-- ALE linter and fixer configurations
vim.g.ale_linters = { python = { "flake8", "mypy" } }
vim.g.ale_fixers = { python = { "black", "isort" } }

