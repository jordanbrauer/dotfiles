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
" Plug 'airblade/vim-gitgutter'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

Plug 'stsewd/fzf-checkout.vim'

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

" Themes
Plug 'tjdevries/colorbuddy.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'jordanbrauer/citylights.nvim'

call plug#end()

"}}}

" 0. Theme {{{
" =============================================================================

" Syntax Highlighting
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

lua << END
local protocol = require('vim.lsp.protocol')
local lualine = require('lualine')
local citylights = require('lualine.themes.citylights')

require('colorbuddy').colorscheme('citylights')
lualine.setup(citylights)

vim.fn.sign_define('DiagnosticSignError', { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define('DiagnosticSignWarn', { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define('DiagnosticSignInfo', { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define('DiagnosticSignHint', { text = "", texthl = "DiagnosticHint" })

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
END

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

" 0. LSP & Treesitter {{{
" =============================================================================

lua << EOF
local servers = { "intelephense", 'gopls', 'tsserver', 'graphql' }
local nvim_lsp = require('lspconfig')
-- lsp_completion = require('completion')

require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
        custom_captures = {},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ensure_installed = {
        "php", "typescript", "go", "gomod", "graphql", "javascript"
    },
}

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- lsp_completion.on_attach()

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD',        '<Cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
  buf_set_keymap('n', 'gd',        '<Cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
  buf_set_keymap('n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
  buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
  buf_set_keymap('n', '<space>gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>',                            opts)
  -- buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
  buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>',                                 opts)
  buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',               opts)
  buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                           opts)
  buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                           opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                         opts)
  buf_set_keymap("n", "<space>f",  "<cmd>lua vim.lsp.buf.formatting()<CR>",                                 opts)
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

function goimports(timeout_ms)
    vim.lsp.buf.formatting()
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
end
EOF

let g:codi#interpreters = {
\   'php': {
\       'bin':    'psysh',
\       'prompt': '^\(λ\|\.\.\.\) ',
\   }
\ }

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
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

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
vnoremap K :m '>-2<CR>gv=gv

" FZF Bindings
nnoremap <silent> <leader>b :exe ":Buffers"<CR>
nnoremap <silent> <leader>h :exe ":History"<CR>
nnoremap <silent> <leader>f :exe ":Files"<CR>
nnoremap <silent> <leader>F :exe ":Rg "<CR>
nnoremap <silent> <leader>r :exe ":Vista!!"<CR>
nnoremap <silent> <leader>R :exe ":Vista finder fzf:nvim_lsp"<CR>
nnoremap <silent> <leader>m :exe ":MinimapToggle"<CR>
nnoremap <silent> <leader>gb :exe ":GBranches"<CR>

" Signify
nnoremap <silent> <tab> :exe ":<c-u>call sy#jump#next_hunk(v:count1)<cr>"
nnoremap <silent> <backspace> :exe ":<c-u>call sy#jump#next_hunk(v:count1)<cr>"

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" }}}

" 0. Misc. {{{
" =============================================================================

"" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


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

augroup MY_IDE
    au!

    autocmd TermOpen * startinsert

    " By default vista.vim never run if you don't call it explicitly.
    "
    " If you want to show the nearest function in your status line automatically,
    " you can add the following line to your vimrc
    " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()

    " EditorConfig
    au FileType gitcommit let b:EditorConfig_disable = 1

    autocmd FileType php setlocal commentstring=#\ %s
    autocmd FileType netrw setlocal colorcolumn=
    autocmd BufWritePre *.go lua goimports(1000)
augroup end
