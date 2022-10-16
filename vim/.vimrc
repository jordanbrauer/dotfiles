" 
"      Welcome to my
"
"    _  __(_)_ _  ________
"   | |/ / /  ' \/ __/ __/
" (_)___/_/_/_/_/_/  \__/                         
"
" Author:    Jordan Brauer
" Requires:  Neovim >= 0.8
" 

" Theme
if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if $COLORTERM == 'truecolor' && has('termguicolors')
	set termguicolors
endif

syntax enable
syntax on

filetype plugin on
set background=dark
let &t_Co=256

lua require('plugins')
lua require('theme')

" Command Line
set noerrorbells
set noshowmode
set noshowcmd
set noruler
set cmdheight=1

" Lines & Columns
set number
set relativenumber
set scrolloff=20
set nowrap
set colorcolumn=80
set textwidth=80
set signcolumn=yes

" Folds
function! FoldedText()
	return printf(' 祈%-4d %s', 1 + v:foldend - v:foldstart, trim(getline(v:foldstart), '#";:{"'))
endfunction

set foldcolumn=2
set foldmethod=marker
set foldtext=FoldedText()
set fillchars=fold:\

" Behaviour
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

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
