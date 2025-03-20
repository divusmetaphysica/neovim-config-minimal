" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

syntax on
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
set noshowmode

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Visualize tabs and newlines
"set listchars=tab:▸\ ,eol:¬

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

" remap leader key
nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = " "

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" Window rotations
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" [W]indows [H] Left
" [W]indows [J] Down
" [W]indows [K] Up
" [W]indows [L] Right
nmap <leader>wh <C-W>h
nmap <leader>wj <C-W>j
nmap <leader>wk <C-W>k
nmap <leader>wl <C-W>l

" [B]uffers [L]ist
" [B]uffers [D]elete
" [B]uffers [N]ext
" [B]uffers [P]revious
nmap <leader>bl :buffers<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>bn :bNext<CR>
nmap <leader>bp :bprevious<CR>

" Insert newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Searching
nnoremap / /\v
vnoremap / /\v
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
" inoremap { {}<Esc>i
" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i

" Formatting
map <leader>q gqip
" Don't use Ex mode, use Q for formatting
map Q gq

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

" ================= PLUGINS ===================

call plug#begin()

" Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'lifepillar/vim-mucomplete'
Plug 'python-mode/python-mode'
Plug 'davidhalter/jedi-vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/jspc.vim'
Plug 'plasticboy/vim-markdown'
Plug 'icymind/NeoSolarized'
Plug 'itchyny/lightline.vim'

call plug#end()


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


let g:pymode_lint = 0
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

colorscheme NeoSolarized
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }
