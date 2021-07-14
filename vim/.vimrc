" 
"      Welcome to my
"
"    _  __(_)_ _  ________
"   | |/ / /  ' \/ __/ __/
" (_)___/_/_/_/_/_/  \__/                         
"
" Author:    Jordan Brauer
" Requires:  Neovim >= 0.5
" 

" 0. Plugins {{{
" =============================================================================

call plug#begin('~/.vim/plugged')

" Language Server
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/completion-nvim'
Plug 'liuchengxu/vista.vim'
Plug 'metakirby5/codi.vim'

" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
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
Plug 'airblade/vim-gitgutter'
Plug 'stsewd/fzf-checkout.vim'

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

"}}}

" 1. Colours {{{
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
colorscheme citylights
set background=dark
let &t_Co=256

" }}}

" Status Bar {{{
" =============================================================================

let g:modes = {
\   'n':      'normal ', 
\   'i':      'insert ', 
\   'R':      'replace', 
\   'c':      'command',
\   'v':      'visual ', 
\   'V':      'v·line ', 
\   "\<C-V>": 'v·block', 
\   'Rv':     'v·replace', 
\ }

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi User1 ctermfg=2 guifg=#54af83
  elseif a:mode == 'r'
    hi User1 ctermfg=3 guifg=#ebda65
  elseif a:mode == 'CTRL-V'
    hi User1 ctermfg=4 guifg=#68a1f0
  elseif a:mode == 'V'
    hi User1 ctermfg=4 guifg=#68a1f0
  elseif a:mode == 'v'
    hi User1 ctermfg=4 guifg=#68a1f0
  elseif a:mode == 'c'
    hi User1 ctermfg=5
  elseif a:mode == 'n'
    hi User1 ctermfg=39 guifg=#5ec4ff
  else
    hi User1 ctermfg=39 guifg=#5ec4ff
  endif
endfunction

function! StatuslineMode(mode)
    return toupper(get(g:modes, a:mode, 'other'))
endfunction

function! StatuslineGitBranch(repo)
    let l:branch = get(a:repo, 'branch', '')

    if l:branch is ''
        return ''
    endif

    return printf(' %s', branch)
    " return printf('ᚠ %s', branch)
endfunction

function! StatuslineGitUntracked(repo)
    let l:branch = get(a:repo, 'branch', '')

    if l:branch is ''
        return ''
    endif

    return printf('+%s', get(a:repo, 'untracked', '0'))
endfunction

function! StatuslineGitChanged(repo)
    let l:branch = get(a:repo, 'branch', '')

    if l:branch isnot ''
        return printf('~%s', get(a:repo, 'changed', '0'))
    endif

    return ''
endfunction

function! StatuslineGitDeleted(repo)
    let l:branch = get(a:repo, 'branch', '')

    if l:branch isnot ''
        return printf('-%s', get(a:repo, 'deleted', '0'))
    endif

    return ''
endfunction

function! StatuslineGitDiverge(repo)
    let l:branch = get(a:repo, 'branch', '')

    if l:branch isnot ''
        return printf('%s %s', get(a:repo, 'ahead', '0'), get(a:repo, 'behind', '0'))
        " return printf('↑%s ↓%s', get(a:repo, 'ahead', '0'), get(a:repo, 'behind', '0'))
    endif

    return ''
endfunction
let g:is_git_dir = 0

function! GetGitBranch()
    let g:is_git_dir = trim(system('git rev-parse --is-inside-work-tree'))

    if g:is_git_dir is# 'true'
        return { 'branch': trim(system('git rev-parse --abbrev-ref HEAD')), 'behind': trim(system('git rev-list --count ..@{u} 2> /dev/null || echo 0')), 'ahead': trim(system('git rev-list --count @{u}.. 2> /dev/null || echo 0')), 'changed': trim(system('git diff --name-only --diff-filter=ad | wc -l')), 'untracked': trim(system('git ls-files -o --exclude-standard | wc -l')), 'deleted': trim(system('git ls-files --deleted | wc -l')) }
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

augroup MY_IDE
    au!

    autocmd TermOpen * startinsert
    autocmd VimEnter,BufEnter,FocusGained,BufWritePost,BufNewFile,CmdwinLeave,BufRead,ShellCmdPost,DiffUpdated,FileChangedShellPost * let b:git_repo = GetGitBranch()
    " autocmd BufEnter,FocusGained,BufWritePost * GetGitBranch()

    autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
    autocmd InsertLeave * call InsertStatuslineColor(mode())

    autocmd VimEnter * hi User1 ctermfg=39 guifg=#5ec4ff ctermbg=none guibg=none cterm=bold gui=bold
    autocmd VimEnter * hi User2 ctermfg=80 guifg=#70e1e8 ctermbg=none guibg=none cterm=none gui=none
    autocmd VimEnter * hi User3 ctermfg=2 guifg=#8bd49c ctermbg=none guibg=none cterm=none gui=none
    autocmd VimEnter * hi User4 ctermfg=3 guifg=#ebbf83 ctermbg=none guibg=none cterm=none gui=none
    autocmd VimEnter * hi User5 ctermfg=1 guifg=#e27e8d ctermbg=none guibg=none cterm=none gui=none
    autocmd VimEnter * hi User6 ctermfg=23 guifg=#008b94 ctermbg=none guibg=none cterm=bold gui=bold
    autocmd VimEnter * hi User7 ctermfg=123 guifg=#9effff ctermbg=none guibg=none cterm=none gui=none
    autocmd VimEnter * hi User8 ctermfg=238 guifg=#41505e ctermbg=none guibg=none cterm=none gui=none
    autocmd VimEnter * hi User9 ctermfg=243 guifg=#718ca1 ctermbg=none guibg=none cterm=bold gui=bold

    " By default vista.vim never run if you don't call it explicitly.
    "
    " If you want to show the nearest function in your status line automatically,
    " you can add the following line to your vimrc
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()

    " EditorConfig
    au FileType gitcommit let b:EditorConfig_disable = 1

    autocmd FileType php setlocal commentstring=#\ %s
    autocmd FileType netrw setlocal colorcolumn=
augroup end

function! IsGit()
    return g:is_git_dir is# 'true'
endfunction

set noshowmode
" set noshowcmd
set noruler
set cmdheight=1
set laststatus=2
set statusline=
set statusline+=%1*\ λ\ %{StatuslineMode(mode())}\ 
set statusline+=\%6*%{IsGit()?StatuslineGitBranch(Repo()).'\ ':''}%1*
set statusline+=\%2*%{IsGit()?'\ '.StatuslineGitDiverge(Repo()).'\ ':''}
set statusline+=\%7*%{IsGit()?'\ '.StatuslineGitUntracked(Repo()).'\ ':''} 
set statusline+=\%7*%{IsGit()?'\ '.StatuslineGitChanged(Repo()).'\ ':''}
set statusline+=\%7*%{IsGit()?'\ '.StatuslineGitDeleted(Repo()).'\ ':''}%1*
set statusline+=%8*%f " full file path
set statusline+=\%{NearestMethodOrFunction()}
set statusline+=\ %9*\(%n\) " buffer ID
set statusline+=\ %3*%{&modified?'[+]':''}
set statusline+=%5*%r
set statusline+=%=
set statusline+=\ %9*Ln%8*\ %l/%L " line number
set statusline+=\ %9*Col%8*\ %v " column number
set statusline+=\ %2p%% " document position
set statusline+=\ 0x%04B\ \(%o\) " current character & byte
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " file encoding
set statusline+=\ %-7([%{&fileformat}]%) " file format (Unix vs. DOS)
set statusline+=%y\ 

" }}}

" LSP {{{
" =============================================================================

" Smooth auto-complete & search experience
set nohlsearch
set incsearch
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')
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
local servers = { "intelephense", 'gopls', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- protocol.SymbolKind
protocol.CompletionItemKind = {
  '', -- Text
  'λ', -- Method
  'λ', -- Function
  '𝑓', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  'π', -- Constant
  '', -- Struct
  '', -- Event
  '', -- Operator
  '', -- TypeParameter
}

require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = false, -- TODO: make true when Citylights TS highlighting ready
        disable = {},
        custom_captures = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "php"
    },
}
EOF

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_icon_indent = ["▸ ", ""]
let g:vista#renderer#icons = {
\   "function": "λ",
\   "method": "λ",
\   "constructor": "𝑓",
\   "constant": "π",
\   "variable": "",
\   "property": "",
\   "namespace": "∷",
\   "class": "",
\ }
let g:vista_default_executive = 'nvim_lsp'
let g:vista_executive_for = {
  \ 'php': 'nvim_lsp',
  \ }
let g:vista_fzf_preview = ['right:50%']

let g:codi#interpreters = {
\   'php': {
\       'bin':    'psysh',
\       'prompt': '^\(λ\|\.\.\.\) ',
\   }
\ }

" }}}

" Memory {{{
" =============================================================================

set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" }}}

" Lines & Columns {{{
" =============================================================================

set number
set relativenumber
set scrolloff=20
set nowrap
set colorcolumn=80
set signcolumn=yes

" }}}

" Formatting {{{
" =============================================================================

filetype indent on

set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" }}}

" Key Map {{{
" =============================================================================
 
" Swap paned buffers with hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" }}}

" Third-Party {{{
" =============================================================================

"" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

" Give FZF a preview window
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" FZF Bindings
nnoremap <silent> <leader>b :exe ":Buffers"<CR>
nnoremap <silent> <leader>h :exe ":History"<CR>
nnoremap <silent> <leader>f :exe ":Files"<CR>
nnoremap <silent> <leader>F :exe ":Rg "<CR>
nnoremap <silent> <leader>r :exe ":Vista!!"<CR>
nnoremap <silent> <leader>R :exe ":Vista finder fzf:nvim_lsp"<CR>
nnoremap <silent> <leader>m :exe ":MinimapToggle"<CR>
nnoremap <silent> <leader>gb :exe ":GBranches"<CR>

let g:minimap_highlight = 'Special'
let g:minimap_base_highlight = 'Comment'
" let g:minimap_left = 1

" Markdown
let g:markdown_fenced_languages = ['js=javascript', 'php', 'vim', 'bash=sh']

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

" }}}

" Misc. {{{
" =============================================================================

set exrc
set makeprg=make
set noerrorbells
set updatetime=50
set foldmethod=marker

let g:netrw_localrmdir='rm -r'

" }}}
