" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set number
set relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

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
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray

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

" Insert newline without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Window splitting directions
set splitbelow
set splitright

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
nnoremap <space> za
augroup AutoSaveFolds
    autocmd!
    autocmd BufWinLeave ?* mkview
    autocmd BufWinEnter ?* silent loadview
augroup END

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Brace completion
" inoremap { {<CR><BS>}<Esc>ko
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬

" Uncomment this to enable by default:
set list " To enable by default

" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" clean trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%Y-%m-%d\ %H:%M\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

" Color scheme (terminal)
set t_Co=256
set background=dark
set termguicolors
colorscheme koehler 

if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L

    if has('gui_win32')
        set guifont=Fira_Code:h10:cANSI
    else
        set guifont=Consolas\ 10
    endif
endif
