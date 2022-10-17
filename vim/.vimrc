" 
"      Welcome to my
"
"    _  __(_)_ _  ________
"   | |/ / /  ' \/ __/ __/
" (_)___/_/_/_/_/_/  \__/                         
"
" Author:    Jordan Brauer
" Published: Apr 20, 2018
" Requires:  Neovim >= 0.8
" 
" Note to the Reader
" ------------------
"
" Much of the configuration found here is heavily supplemented by Lua code
" specific to NeoVim found within the config/.config/nvim/ directory in this
" repository.
"
" The responsibility of this configuration lies primarily in simple settings
" such as sets, lets, and other minor, global configuration values.
"

" Behaviour
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

filetype plugin on
filetype indent on

set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set formatoptions-=t

set exrc
set iskeyword+=-
set updatetime=100
set clipboard+=unnamedplus

" Autocomplete & Search
set nohlsearch
set incsearch
set completeopt=menu,menuone,noselect
set shortmess+=c

" Lines & Columns
set number
set relativenumber
set scrolloff=20
set nowrap
set colorcolumn=80
set textwidth=80
set signcolumn=yes

" Theme
let &t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if $COLORTERM == 'truecolor' && has('termguicolors')
	set termguicolors
endif

set background=dark

syntax enable

" Command Line
set noerrorbells
set noshowmode
set noshowcmd
set noruler
set cmdheight=1

" Folds
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=0
set foldlevel=1
set fillchars=fold:\ 
