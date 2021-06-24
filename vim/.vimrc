" ================
" Plugins
" =============================================================================

call plug#begin('~/.vim/plugged')
" Language Server
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'liuchengxu/vista.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" Formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" PHP
Plug 'jordanbrauer/php.vim'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Markdown
Plug 'tpope/vim-markdown'

" Themes
Plug 'jordanbrauer/citylights.vim'
call plug#end()

" =============================================================================
" Misc.
" =============================================================================

set makeprg=make
set exrc
set encoding=utf-8
set noerrorbells
set nohlsearch
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set cmdheight=1
" set termguicolors
set signcolumn=yes
set updatetime=50

" =============================================================================
" Colours
" =============================================================================

syntax enable
syntax on
colorscheme citylights
set background=dark
let &t_Co=256

if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

function! Make(args)
    exe ':vert term make ' . a:args
endfunction

command! -bang -nargs=? Make call Make(<q-args>)

" Show syntax highlighting groups for word under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1) 
    echo printf('Syntax: %s → %s', synIDattr(l:s, 'name'), synIDattr(synIDtrans(l:s), 'name'))
endfun
map gm :call SynGroup()<CR>

" =============================================================================
" Status Bar
" =============================================================================

let g:modes = {'n': 'normal', 'v': 'visual', 'V': 'v·line', "\<C-V>": 'v·block', 'i': 'insert', 'R': 'replace', 'Rv': 'v·replace', 'c': 'command'}
" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_icon_indent = ["▸ ", ""]
let g:vista#renderer#icons = {
\   "function": "λ",
\   "method": "λ",
\   "constructor": "𝑓",
\   "constant": "π",
\   "variable": "x",
\   "property": "→",
\   "namespace": "∷",
\   "class": "✢",
\  }
let g:vista_default_executive = 'nvim_lsp'
let g:vista_executive_for = {
  \ 'php': 'nvim_lsp',
  \ }
let g:vista_fzf_preview = ['right:50%']


function! InsertStatuslineColor(mode)
    " echo a:mode
  if a:mode == 'i'
    hi User1 ctermbg=2
    hi User2 ctermbg=2
  elseif a:mode == 'r'
    hi User1 ctermbg=3
    hi User2 ctermbg=3
  elseif a:mode == 'CTRL-V'
    hi User1 ctermbg=4
    hi User2 ctermbg=4
  elseif a:mode == 'V'
    hi User1 ctermbg=4
    hi User2 ctermbg=4
  elseif a:mode == 'v'
    hi User1 ctermbg=4
    hi User2 ctermbg=4
  elseif a:mode == 'c'
    hi User1 ctermbg=5
    hi User2 ctermbg=5
  elseif a:mode == 'n'
    hi User1 ctermbg=1
    hi User2 ctermbg=1
  else
    hi User1 ctermbg=1
    hi User2 ctermbg=1
  endif
endfunction

function! StatuslineMode(mode)
    " call InsertStatuslineColor(a:mode)
    return toupper(get(g:modes, a:mode, 'other'))
endfunction

function! StatuslineGitBranch(repo)
    let l:branch = get(a:repo, 'branch', '')

    if l:branch isnot ''
        return printf('ᚠ %s (↑%s ↓%s +%s ~%s -%s)', branch, get(a:repo, 'ahead', '0'), get(a:repo, 'behind', '0'), get(a:repo, 'untracked', '0'), get(a:repo, 'changed', '0'), get(a:repo, 'deleted', '0'))
    endif

    return ''
endfunction

" Parse git information for the current project/file
function! GetGitBranch()
    let l:is_git_dir = trim(system('git rev-parse --is-inside-work-tree'))

    if l:is_git_dir is# 'true'
        return { 'branch': trim(system('git rev-parse --abbrev-ref HEAD')), 'behind': trim(system('git rev-list --count ..@{u}')), 'ahead': trim(system('git rev-list --count @{u}..')), 'changed': trim(system('git diff --name-only --diff-filter=ad | wc -l')), 'untracked': trim(system('git ls-files -o --exclude-standard | wc -l')), 'deleted': trim(system('git ls-files --deleted | wc -l')) }
    else
        return {'branch': ''}
    endif
endfunction

function! Repo()
    if !has_key(b:, 'git_repo')
        let b:git_repo = GetGitBranch()
    endif

    return get(b:, 'git_repo', {})
endfunction

function! NearestMethodOrFunction() abort
  return trim(printf(':%s', get(b:, 'vista_nearest_method_or_function', '')), ':', 2)
endfunction

augroup GIT_STATUS
    au!

    autocmd TermOpen * startinsert
    autocmd VimEnter,BufEnter,FocusGained,BufWritePost,BufNewFile,CmdwinLeave,BufRead,ShellCmdPost,DiffUpdated,FileChangedShellPost * let b:git_repo = GetGitBranch()
    " autocmd BufEnter,FocusGained,BufWritePost * GetGitBranch()

    autocmd InsertEnter,InsertLeave * call InsertStatuslineColor(v:insertmode)
    autocmd InsertLeave * hi User2 ctermbg=1
    autocmd InsertLeave * hi User1 ctermbg=1

    autocmd VimEnter * hi User1 cterm=bold ctermbg=1 ctermfg=0
    autocmd VimEnter * hi User2 ctermbg=1 ctermfg=0

    " By default vista.vim never run if you don't call it explicitly.
    "
    " If you want to show the nearest function in your statusline automatically,
    " you can add the following line to your vimrc
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup end

set noshowmode
" set noshowcmd
" set noruler
set laststatus=2
set statusline=
set statusline+=%2*\ λ\ %{StatuslineMode(mode())}
set statusline+=\ %1*%{StatuslineGitBranch(Repo())}%2*
set statusline+=\ %f " full file path
set statusline+=\%{NearestMethodOrFunction()}
set statusline+=\ \(%n\) " buffer ID
set statusline+=\ %{&modified?'[+]':''}
set statusline+=\ %r
set statusline+=%=
set statusline+=\ %1*Ln%2*\ %l/%L " line number
set statusline+=\ %1*Col%2*\ %v " column number
set statusline+=\ %2p%% " document position
set statusline+=\ 0x%04B\ \(%o\) " current character & byte
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " file encoding
set statusline+=\ %-7([%{&fileformat}]%) " file format (unix vs. dos)
set statusline+=%y " file type

" =============================================================================
" LSP
" =============================================================================

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" Avoid showing message extra message when using completion
set shortmess+=c

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

augroup IDE
    au!

    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()
augroup end

lua << EOF
local nvim_lsp = require('lspconfig')
-- lsp_completion = require('completion')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- lsp_completion.on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "intelephense" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

" Lines
set number
set relativenumber
set scrolloff=20
set nowrap

" Tabs
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
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
let g:NERDTreeWinSize=40
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
nnoremap <silent> <leader>F :call FZFOpen(":Rg ")<CR>
nnoremap <silent> <leader>zh :call FZFOpen(":History")<CR>
nnoremap <silent> <leader>r :exe ":Vista!!"<CR>
nnoremap <silent> <leader>R :exe ":Vista finder fzf:nvim_lsp"<CR>

filetype plugin on
" set omnifunc=syntaxcomplete#Complete
" autocmd FileType php setlocal omnifunc=phpactor#Complete

" Markdown
let g:markdown_fenced_languages = ['js=javascript', 'php', 'vim', 'bash=sh']

