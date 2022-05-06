" 
"      Welcome to my
"
"    _  __(_)_ _  ________
"   | |/ / /  ' \/ __/ __/
" (_)___/_/_/_/_/_/  \__/                         
"
" Author:    Jordan Brauer
" Requires:  Neovim >= 0.6
" 

" 0. Plugins {{{
" =============================================================================

call plug#begin('~/.vim/plugged')

" Language Server
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'
Plug 'liuchengxu/vista.vim'
Plug 'metakirby5/codi.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim' " dependency of harpoon; telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-vinegar'
Plug 'wfxr/minimap.vim'

" Formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" Git
Plug 'tpope/vim-fugitive'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" PHP
Plug 'jordanbrauer/php.vim'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Markdown
Plug 'tpope/vim-markdown'

" Ops
Plug 'earthly/earthly.vim', { 'branch': 'main' }
Plug 'hashivim/vim-terraform'

" Themes
Plug 'tjdevries/colorbuddy.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'jordanbrauer/citylights.nvim'

call plug#end()

"}}}

" 0. Theme {{{
" =============================================================================

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
    return printf(' 祈%-4d %s', 1 + v:foldend - v:foldstart, trim(getline(v:foldstart), '#";:{'))
endfunction

set foldcolumn=2
set foldmethod=marker
set foldtext=FoldedText()
set fillchars=fold:\ 

" Vista (plugin)
let g:vista_icon_indent = ["▸ ", ""]
let g:vista#renderer#icons = {
\   "function":    "λ",
\   "method":      "λ",
\   "constructor": "𝑓",
\   "constant":    "π",
\   "variable":    "",
\   "property":    "",
\   "namespace":   "∷",
\   "class":       "",
\ }

let g:vista_fzf_preview = ['right:50%']

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_default_executive = 'nvim_lsp'
let g:vista_executive_for = {
  \ 'php': 'nvim_lsp',
  \ }

" Minimap (plugin)
let g:minimap_highlight = 'Special'
let g:minimap_base_highlight = 'Comment'
" let g:minimap_left = 1

" Markdown
let g:markdown_fenced_languages = ['js=javascript', 'php', 'vim', 'bash=sh']

" }}}

" 0. Behaviour {{{
" =============================================================================

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
set makeprg=make
set iskeyword+=-
set updatetime=100
set clipboard+=unnamedplus

" NetRW
let g:netrw_localrmdir='rm -r'

" Smooth auto-complete & search experience
set nohlsearch
set incsearch
set completeopt=menu,menuone,noselect
set shortmess+=c

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" fzf
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

" Give FZF a preview window
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" }}}

" 0. Key Map {{{
" =============================================================================
 
" Swap paned buffers with ctrl+<hjkl>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move selected lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" FZF Bindings
nnoremap <silent> <leader>f <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>F <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>h :exe ":History"<CR>
nnoremap <silent> <leader>r :exe ":Vista!!"<CR>
nnoremap <silent> <leader>R :exe ":Vista finder fzf:nvim_lsp"<CR>
nnoremap <silent> <leader>gb <cmd>Telescope git_branches<CR>
nnoremap <silent> <leader>m :exe ":MinimapToggle"<CR>

" Signify
nnoremap <silent> <tab> :exe ":<c-u>call sy#jump#next_hunk(v:count1)<cr>"
nnoremap <silent> <backspace> :exe ":<c-u>call sy#jump#next_hunk(v:count1)<cr>"

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Harpoon
nnoremap <silent> <leader>c :exe ":lua require('harpoon.ui').toggle_quick_menu()"<CR>
nnoremap <silent> <leader>a :exe ":lua require('harpoon.mark').add_file()"<CR>

" Vim Snip
" NOTE: You can use other key to expand snippet.
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" Show syntax highlighting groups for word under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1) 
    echo printf('Syntax: %s → %s', synIDattr(l:s, 'name'), synIDattr(synIDtrans(l:s), 'name'))
endfun

map gm :call SynGroup()<CR>

" }}}

" 0. Misc. {{{
" =============================================================================

"" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

function! Make(args)
    exe ':vert term make ' . a:args
endfunction

command! -bang -nargs=? Make call Make(<q-args>)

augroup MY_IDE
    au!

    autocmd TermOpen * startinsert

    " By default vista.vim never run if you don't call it explicitly.
    "
    " If you want to show the nearest function in your status line automatically,
    " you can add the following line to your vimrc
    " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

    " Use completion-nvim in every buffer
    " autocmd BufEnter * lua require'completion'.on_attach()

    " EditorConfig
    au FileType gitcommit let b:EditorConfig_disable = 1

    autocmd FileType php setlocal commentstring=#\ %s
    autocmd FileType netrw setlocal colorcolumn=
    autocmd BufNewFile,BufRead *.mdx   set syntax=markdown
    autocmd BufWritePre *.go lua require('go').imports(1000)
    autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
augroup end

" }}}
