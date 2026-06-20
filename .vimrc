" Colours
set t_Co=256
set background=dark
syntax enable

" No bells
set noerrorbells
set novisualbell
set t_vb=
set belloff=all

" Misc
set backspace=indent,eol,start
set fileformat=unix
set modelines=1
set autochdir

" Indentation
set autoindent
set nosmartindent
set nocindent

" Spaces and Tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Display
set ruler
set number
set relativenumber
set scrolloff=5
" show the matching part of the pair for [] {} and ()
set showmatch
" allow <leader> to be displayed
set showcmd
"set bash type wildcard
set wildmode=longest,list
set lazyredraw

" Folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" Backups
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" Filetype recognition for plugins and indents
filetype plugin indent on

" Mapleader
let mapleader = ","
let g:mapleader = ","
inoremap jk <esc>
nnoremap gV `[v`]
nnoremap <leader><space> :nohlsearch<CR>

" To disable F1 for help
noremap <F1> <NOP>
noremap! <F1> <NOP>
" F2 = show / hide invisible characters
noremap <F2> :se list!<CR>
" F3 = toggle numbering
noremap <F3> :call ToggleNumbering()<CR>
" F4 = set paste mode
noremap <F4> :se paste!<CR>
" F5 = toggle NERDTree
noremap <F5> :NERDTreeToggle<CR>
" F6 = toggle search highlights
noremap <F6> :se hls!<CR>
" F8 = set bg=light
nnoremap <F8> :call ToggleBackground()<CR>
" F9 = run Python
augroup pythonexec
    autocmd!
    autocmd FileType python nnoremap <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python inoremap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END

augroup filegroups
    autocmd!
    autocmd BufRead,BufNewFile *.py let python_highlight_all = 1
    autocmd BufRead,BufNewFile *.yaml,*.yml setlocal filetype=yaml
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent nosmartindent nocindent foldmethod=indent
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent nosmartindent nocindent
augroup END

" Toggle background between dark and light (default: dark)
let g:bg_is_light = 0
function! ToggleBackground()
    if g:bg_is_light
        :set background=dark
        let g:bg_is_light = 0
    else
        :set background=light
        let g:bg_is_light = 1
    endif
endfunction

" Toggle numbering
function! ToggleNumbering()
    :set number!
    :set relativenumber!
endfunction

" Strip trailing whitespace
function! StripTrailingWhitespaces()
    call Preserve("%s/\\s\+$//e")
endfunction

" Preserves cursor location before running a command
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

execute pathogen#infect()
set laststatus=2
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1

" Solarized
let g:solarized_termtrans = 1
colorscheme solarized

" highlight trailing whitespace
highlight trailingWhitespace ctermbg=Red guibg=Red
call matchadd('trailingWhitespace', '/\s\+$/')

" highlight right margin
highlight rightMargin ctermbg=Red guibg=Red
" call matchadd('rightMargin', '/.\%>80v/')
