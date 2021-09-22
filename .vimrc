" Don't try to be vi compatible
set nocompatible
filetype off
syntax on
filetype plugin indent on
set encoding=utf-8

" Search down into subfolders
" provides tab completion for all file related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
set modelines=0
set exrc
set secure
set number
set relativenumber
set ruler
set visualbell
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history

" Don't use Ex mode, use Q for formatting
map Q gq

" When doing tab completion, give the following files lower priority.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
autocmd BufRead APKBUILD set filetype=sh

" Whitespace
set wrap
set textwidth=99
set formatoptions=tcqrn1
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set smartindent
set noshiftround
" set colorcolumn=100
" highlight ColorColumn ctermbg=darkgray

set hidden       " Allow hidden buffers
set ttyfast      " Rendering
set laststatus=2 " Status bar
set showmode     " Last line
set showcmd
set splitbelow   " Window splitting directions
set splitright
set list         " Uncomment this to enable by default:

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬

" This will enable
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" Autocompletion is already enabled with ctags
" - ^x^n for JUST this file
" - ^x^f for filenames (works with out path trick!)
" - ^x^] for tags only
" - ^n for anythign specified by the 'complete' option
" - Use ^n and ^p to go back and forth in the suggestion list
" 
" Overview: In insert mode you can...
" 
" ^r = insert text from a register
" ^a = insert text from register '.'
" ^p = completion menu
" ^x = special "completion mode" submode of insert
" --^] = tag
" --^p = pull from previous context
" --^n = pull from next context
" --^f = file completion
" --^l = line
" --^o = omnicompletion
" 
" How to change where to complete from:
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,t,i,kspell

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
let mapleader=","

" Insert newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search
nnoremap <F3> :set hlsearch!<CR>

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <C-space> za

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Brace completion
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i

" Formatting
map <leader>q gqip

" Remap ^] to ^ä
map <C-ä> <C-]> 

" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" clean trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%Y-%m-%d\ %H:%M:%S\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

" Color scheme (terminal)
set t_Co=256
set background=dark
set termguicolors
colorscheme koehler

if has('gui_running')
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1

    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L

    if has('gui_win32')
        set guifont=Consolas\ 10
    else
        set guifont=Source_Code_Pro:h10:cANSI
    endif
endif

" ================= PLUGINS ===================

let g:pymode_lint = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length 99'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

" Load plugins here (pathogen or vundle)
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle/')

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'scrooloose/nerdtree'
Plugin 'lifepillar/vim-mucomplete'

" =========== Python ============
Plugin 'python-mode/python-mode'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'

" =========== Javascript ========
Plugin 'othree/es.next.syntax.vim'
Plugin 'othree/jspc.vim'

" =========== Other =============
" Plugin 'xavierd/clang_complete'
Plugin 'plasticboy/vim-markdown'

" =========== Themes ============
Plugin 'icymind/NeoSolarized'
Plugin 'morhetz/gruvbox'
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()

let g:SimpylFold_docstring_preview=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set completeopt-=preview
set completeopt+=menuone,noselect
set shortmess+=c  " Shut off completion messages
set belloff+=ctrlg
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1

" autocmd VimEnter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <A-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree

let g:pymode_python = "python3"
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#usages_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" let g:clang_library_path = '/usr/lib/llvm-7/lib/libclang-7.so.1'
" let g:clang_user_options = '-std=c11 -Wall -Wextra -pedantic'
" let g:clang_complete_auto = 1

colorscheme dracula
let g:airline_theme='dracula'
