set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

"call plug#begin(stdpath('data') . '/plugged')
call plug#begin('~/.vim/plugged')

" lsp Plugins and autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" Install LSP servers automatically 
" Plug 'williamboman/nvim-lsp-installer'

" Code actions and symbols view
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Neovim Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
"
" Debugger Plugins
Plug 'mfussenegger/nvim-dap'
" Author of below plugin is doing a rewrite
" Plug 'Pocco81/DAPInstall.nvim'
Plug 'szw/vim-maximizer'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" The ThePrimeagen plugins
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'ThePrimeagen/harpoon'

" tpope awesome plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" prettier
Plug 'sbdchd/neoformat'

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', {'name': 'dracula'}

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

lua require("tostca")
" lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

set completeopt=menu,menuone,noselect 

set termguicolors " enable true colors support
"let ayucolor="dark"
let g:dracula_colorterm = 0
colorscheme dracula

let mapleader = " "
nnoremap <leader>pv :Vex!<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
" nnoremap <C-p> :GFiles<CR>
" nnoremap <leader>pf :Files<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <leader>pa o<esc>P<CR>

vnoremap <leader>y "+y
nnoremap <leader>y "+y
vnoremap <leader>p "_dP
nnoremap <leader>Y gg"+y

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

nnoremap <leader>x :silent !chmod +x %<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Nerd tree
nnoremap <C-n> :NvimTreeToggle<CR>

" Highligt on yank.
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
