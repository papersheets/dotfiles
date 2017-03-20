"       /usr/local/bin/vim (7.0) and
"       /usr/local/bin/gvim (7.0)
"this line prevents copydotfiles from recopying: dot-vimrc_included

if &term =~ "xterm"
  if has("terminfo")
    set t_Co=8
    set t_Sf=^[[3%p1%dm
    set t_Sb=^[[4%p1%dm
  else
    set t_Co=8
    set t_Sf=^[[3%dm
    set t_Sb=^[[4%dm
  endif
endif

set term=xterm-256color

set backspace=indent,eol,start

set autoindent
set smartindent
set cindent

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ruler
set number
set relativenumber
set textwidth=79
set fileformat=unix

" show the matching part of the pair for [] {} and ()
set showmatch

set scrolloff=5

"set bash type wildcard
set wildmode=longest,list

"Set Mapleader
let mapleader = ","
let g:mapleader = ","

"set showcmd to allow <leader> to be displayed
set showcmd

set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

"filetype recognition for plugins
filetype plugin on
filetype plugin indent on

" enable all Python syntax highlighting features
let python_highlight_all = 1

"syntax highlighting
syntax on

"default to dark
set bg=dark

" disable help and map F1 to toggle search highlights instead
noremap <F1> :se hls!<cr>
noremap! <F1> :se hls!<cr>
" F2 = show / hide invisible characters
noremap <F2> :se list!<cr>
noremap! <F2> :se list!<cr>
" F3 = toggle numbering
noremap <F3> :call ToggleNumbering()<cr>
" F4 = set paste mode
noremap <F4> :se paste!<cr>
noremap! <F4> :se paste!<cr>
" F5 = toggle NERDTree
map <F5> :NERDTreeToggle<cr>

"NERDTree
map <Leader>, :NERDTreeToggle<cr>

" F8 = set bg=light
nnoremap <F8> :call ToggleBackground()<cr>
let g:bg_is_light = 0

" F9 execute python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

function! ToggleBackground()
    if g:bg_is_light
        :set bg=dark
        let g:bg_is_light = 0
    else
        :set bg=light
        let g:bg_is_light = 1
    endif
endfunction

function! ToggleNumbering()
    :set number!
    :set relativenumber!
endfunction

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" highlight right margin
highlight rightMargin ctermbg=Red guibg=Red
match rightMargin /.\%>80v/

" highlight trailing whitespace
highlight trailingWhitespace ctermbg=Red guibg=Red
match trailingWhitespace /\s\{1,}$/

" my stuff
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

"solarized
let g:solarized_termtrans = 1
colorscheme solarized
