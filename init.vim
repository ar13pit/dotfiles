""""""" Plugin management stuff """""""
set nocompatible
filetype off

call plug#begin('~/.config/nvim/bundle')

" Custom plugins...
" Code folding
Plug 'tmhedberg/SimpylFold'
" Autocompletion
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neco-vim'
Plug 'deoplete-plugins/deoplete-jedi'
" File browsing
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'
" Comment plugin
Plug 'scrooloose/nerdcommenter'
" Git plugin
Plug 'tpope/vim-fugitive'
" Quotes/Braces completion
Plug 'tpope/vim-surround'
" Syntax check
Plug 'dense-analysis/ale'

" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Fuzzy search tool for both shell and vim
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Remove extraneous whitespace when edit mode is exited
"Plug 'thirtythreeforty/lessspace.vim'

" Screen splitter.  Cool, but doesn't work with nvim.
"Plug 'ervandew/screen'

" Neomake build tool (mapped below to <c-b>)
"Plug 'benekastah/neomake'

" EasyMotion - Allows <leader><leader>(b|e) to jump to (b)eginning or (end)
" of words.
"Plug 'easymotion/vim-easymotion'

" LaTeX editing
"Plug 'LaTeX-Box-Team/LaTeX-Box'

" Status bar mods
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

" Color schemes
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'

" Tab completion
"Plug 'ervandew/supertab'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Google auto-format tools
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Shell formatter
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" After all plugins...
call plug#end()
call glaive#Install()
" Fix cursor issues
filetype plugin indent on


""""""""""""""""""""""""""""""""""
"      Normal mode settings
""""""""""""""""""""""""""""""""""
" set guicursor:
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

" Python support
" let g:loaded_python_provider=1
let g:python_host_prog = '/usr/bin/python'

" Real programmers do not use TABS but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set textwidth=120
set autoindent

" Set default file format to unix
set fileformat=unix

" File encoding
set encoding=utf-8

" Display line numbers on the left margin
set number

" Display tabs with > and spaces with -
set list

" Enable code folding
set foldmethod=syntax
set foldlevel=99

" Update time for vim-gitgutter
set updatetime=100
" Sign column for vim-gitgutter
set signcolumn=yes

"""""" Auto formatting """"""
"augroup autoformat_settings
"  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType c,cpp,proto,javascript,cuda AutoFormatBuffer clang-format
"  autocmd FileType dart AutoFormatBuffer dartfmt
"  autocmd FileType go AutoFormatBuffer gofmt
"  autocmd FileType gn AutoFormatBuffer gn
"  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
"  autocmd FileType java AutoFormatBuffer google-java-format
"  autocmd FileType python AutoFormatBuffer yapf
"  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
"augroup END
map <leader>f :FormatCode

" Deoplete autocompletion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" NERDTree & Commenter configurations
let NERDTreeIgnore=['\.pyc$', '\~$'] "Ignore files in NERDTree
map <C-\> :NERDTreeToggle<CR>
map <A-\> :NERDTreeFocus<CR>
augroup nerdtree_settings
    " If only open window is NERDTree, then close it
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " If more than one window and previous buffer was NERDTree, go back to it.
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
augroup END

let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
nmap <C-_> <leader>c<space>
vmap <C-_> <leader>cs

" Color scheme configuration
colorscheme slate

" Syntax highlighting
let python_highlight_all=1
syntax on
let g:ale_linters = { 'python': ['pylint', 'flake8'], 'cpp': ['clangtidy'], 'c': ['clangtidy'] }
let g:ale_fixers = { 'cpp': ['clang-format'], 'c': ['clang-format'] }
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_python_pylint_change_directory = 1
let g:ale_python_flake8_change_directory = 1

" Gutentags configuration
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir = '~/.nvimtags'

" Tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Gitgutter configuration
highlight GitGutterAdd ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
highlight GitGutterDelete ctermfg=1 ctermbg=0
"let g:gitgutter_highlight_lines = 1

" Editorconfig configuration
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Screen splits
set splitbelow
set splitright

"""""" Key remaps """"""
" Code folding
nnoremap <space> za

" Window movement remaps
" Not using the ALT key because of Terminator
" Move up
nnoremap <C-Up>     <C-W><C-K>
" Move down
nnoremap <C-Down>   <C-W><C-J>
" Move left
nnoremap <C-Left>   <C-W><C-H>
" Move right
nnoremap <C-Right>  <C-W><C-L>

" Window split and terminal open shortcut
function! Term()
    exec winheight(0)/4."split" | terminal
endfunction
nnoremap <expr> <C-t> ":call Term()\<CR>"

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

"""""""""""""""""""""""""""""""
"      Terminal Settings
"""""""""""""""""""""""""""""""
augroup terminal_settings
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
    autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END

" Insert mode to normal mode
tnoremap <Esc> <C-\><C-n>

set modelines=0
set nomodeline
" Allow usage of per project .vimrc file
set exrc
" Disallow the use of :autocmd, shell and write commands in local .vimrc files
set secure
