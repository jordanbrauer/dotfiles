" =============================================================================
" Plugins
" =============================================================================

call plug#begin('~/.vim/plugged')
" Files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" Formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" PHP
Plug 'StanAngeloff/php.vim'
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}

" Markdown
Plug 'tpope/vim-markdown'

" Themes
Plug 'arcticicestudio/nord-vim'
call plug#end()

" =============================================================================
" Misc.
" =============================================================================

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
" Status Bar
" =============================================================================

let g:modes = {'n': 'normal', 'v': 'visual', 'V': 'v·line', "\<C-V>": 'v·block', 'i': 'insert', 'R': 'replace', 'Rv': 'v·replace', 'c': 'command'}

function! InsertStatuslineColor(mode)
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
        return printf('ᚠ %s ⤴%s ⤵%s +%s ~%s -%s', branch, get(a:repo, 'ahead', '0'), get(a:repo, 'behind', '0'), get(a:repo, 'untracked', '0'), get(a:repo, 'changed', '0'), get(a:repo, 'deleted', '0'))
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

augroup GIT_STATUS
    au!

    autocmd VimEnter,BufEnter,FocusGained,BufWritePost,BufNewFile,CmdlineLeave,CmdwinLeave,BufRead,ShellCmdPost,DiffUpdated,FileChangedShellPost * let b:git_repo = GetGitBranch()
    " autocmd BufEnter,FocusGained,BufWritePost * GetGitBranch()

    autocmd InsertEnter,InsertLeave * call InsertStatuslineColor(v:insertmode)
    " autocmd CmdlineEnter * call InsertStatuslineColor('c')
    " autocmd InsertLeave,CmdlineLeave,CmdwinLeave,WinLeave,WinEnter * call InsertStatuslineColor(mode())
    autocmd InsertLeave * hi User2 ctermbg=1
    autocmd InsertLeave * hi User1 ctermbg=1

    autocmd VimEnter * hi User1 cterm=bold ctermbg=1 ctermfg=0
    autocmd VimEnter * hi User2 ctermbg=1 ctermfg=0
augroup end

" hi StatusLine term=reverse cterm=bold ctermbg=5 gui=undercurl guisp=Magenta
" hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse

set noshowmode
" set noshowcmd
" set noruler
set laststatus=2
set statusline=
set statusline+=%2*\ λ\ %{StatuslineMode(mode())}
set statusline+=\ %1*%{StatuslineGitBranch(Repo())}%2*
set statusline+=\ %F " full file path
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
" Colours
" =============================================================================

syntax enable
syntax on
colorscheme nord
set background=dark
let &t_Co=256

if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

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
nnoremap <silent> <leader>zh :call FZFOpen(":History")<CR>

"" Php autocomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd FileType php setlocal omnifunc=phpactor#Complete

" Markdown
let g:markdown_fenced_languages = ['js=javascript', 'php', 'bash=sh']

