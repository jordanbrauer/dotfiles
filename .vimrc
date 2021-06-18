call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'StanAngeloff/php.vim'
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
Plug 'arcticicestudio/nord-vim'
" Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

set encoding=utf-8
set visualbell

" Add colour
syntax enable
syntax on
colorscheme nord
set background=dark
let &t_Co=256

if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"" Show line numbers.
set number
set relativenumber

"" Normal indentation
filetype indent on
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent

" Swap paned buffers with hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
au FileType gitcommit let b:EditorConfig_disable = 1

" NerdTree
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=80
let g:NERDTreeWinPos = "right"
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" NerdTree bindings
map <C-b> :NERDTreeToggle<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ vsplit new | exe "NERDTreeFocus" | exe "vertical resize 80" | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

" Give FZF a preview window
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" Prevent FZF commands from opening in none modifiable buffers
" and always open to the left of NerdTree
function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    " NERD tree or Quickfix type
    if bufname('%') =~ 'NERD_tree' && bufname('#') !~ 'NERD_tree' && winnr('$') > 1 && (!&modifiable || &ft == 'nerdtree' || &ft == 'qf')
	b#
	exe "normal! \<c-w>\<c-w>"
	:blast
    endif
    exe a:cmd
endfunction

" FZF bindings
nnoremap <silent> <leader><leader> :call FZFOpen(":Buffers")<CR>
nnoremap <silent> <leader>f :call FZFOpen(":Files")<CR>
nnoremap <silent> <leader>zh :call FZFOpen(":History")<CR>

"" Php autocomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd FileType php setlocal omnifunc=phpactor#Complete
