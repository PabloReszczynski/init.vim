set nocompatible
filetype off
" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'                " NERD tree
Plug 'scrooloose/nerdcommenter'           " NERD Commenter <leader>cc
"Plug 'tpope/vim-surround'                 " Surround parens
Plug 'Townk/vim-autoclose'                " Auto pairs
Plug 'majutsushi/tagbar'                  " Tagbar
Plug 'mhinz/vim-startify'                 " Start screen
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'             " Git +-
Plug 'vim-airline/vim-airline'            " Airline
Plug 'vim-airline/vim-airline-themes'     " Airline themes
Plug 'keith/tmux.vim'                     " TMUX
Plug 'edkolev/tmuxline.vim'               " TMUX line
"Plug 'PotatoesMaster/i3-vim-syntax'       " i3
"Plug 'jgdavey/tslime.vim'                 " Send to tmux
Plug 'sheerun/vim-polyglot'               " Syntax highlighting
Plug 'justinmk/vim-syntax-extra'          " More Syntax highlighting
"Plug 'ervandew/supertab'                  " Auto complete with Tab
Plug 'rking/ag.vim'                       " Project Search
Plug 'eagletmt/neco-ghc'                  " Haskell autocomplete
Plug 'bhurlow/vim-parinfer'               " Lisp Parinfer
Plug 'kien/rainbow_parentheses.vim'       " Rainbow parens
Plug 'Chiel92/vim-autoformat'             " Auto Formatting
Plug 'tpope/vim-fireplace'                " Clojure
Plug 'guns/vim-clojure-static'            " Clojure syntax
Plug 'guns/vim-clojure-highlight'         " Clojure syntax + fireplace
" Only NeoVim
if has("nvim")
  Plug 'Shougo/deoplete.nvim'               " Asynchronous autocomplete
  Plug 'Shougo/neoinclude.vim'              " Autocomplete header files
  Plug 'Shougo/denite.nvim'                 " Helm-like
  Plug 'Shougo/context_filetype.vim'        " Other file autocompletion
  Plug 'zchee/deoplete-jedi'                " Async Python autocomplete
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } "JS
  Plug 'zchee/deoplete-clang'               "C, C++  autocompletion
  "Plug 'neomake/neomake'                    " Like Syntastic
  "Plug 'benjie/neomake-local-eslint.vim'    " Use local eslint instead of global
  "Plug 'joshdick/onedark.vim'               " Theme
endif
call plug#end()
filetype plugin indent on

" PATH
let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" NVIM
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Space is leader key
nnoremap <Space> <Nop>
let mapleader = " "

" Startify
let g:startify_custom_header =
      \ map(split(system('todo.sh'), '\n'), '"   ". v:val')

" Deoplete
if has("nvim")
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_smart_case = 1
  let g:context_filetype#same_filetypes = {}
  let g:context_filetype#same_filetypes._ = '_'
  "let g:deoplete#sources={}
  "let g:deoplete#sources._=['buffer', 'tag', 'file']
  "let g:tern#filetypes = ['jsx']
  inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endif

" timeout
set ttimeout
set ttimeoutlen=0

" Folding
set foldmethod=indent
set foldlevel=99

" mappings
map <F2> :NERDTreeToggle<CR>
map <F3> :TagbarToggle<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag

" CtrlP settings
let g:ctrlp_match_window = "bottom,order:ttb"
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

if has("nvim")
  nnoremap <C-p> :Denite file_rec<CR>
endif

" UI
set nu
set showcmd
set wildmenu
set wildmode=list:longest,full
set showmatch
set ruler
set laststatus=2

set background=dark
"if filereadable(expand("~/.vimrc_bakground"))
"  let base16colorspace=256
"  source ~/.vimrc_background
"endif

if has("nvim")
  set termguicolors
  let base16colorspace=256
  let t_Co=256
  let g:airline_theme='base16_shell'
endif
if has("gui_running")
  set guifont=Fira\ Code:h20
  let g:airline_theme='base16'
endif
colorscheme base16-nord

highlight Comment cterm=italic term=italic
set cursorline

" Rainbow Parens
if has("nvim")
let g:rbpt_colorpairs = [
  \ ['red',       g:terminal_color_8],
  \ ['brown',     g:terminal_color_9],
  \ ['yellow',    g:terminal_color_10],
  \ ['green',     g:terminal_color_11],
  \ ['lightblue', g:terminal_color_12],
  \ ['blue',      g:terminal_color_13],
  \ ['magenta',   g:terminal_color_14],
  \ ['brown',     g:terminal_color_15]
  \ ]
endif

let g:rbpt_max = 8

autocmd VimEnter *       RainbowParenthesesToggle
autocmd Syntax   clojure RainbowParenthesesLoadRound
autocmd Syntax   clojure RainbowParenthesesLoadSquare
autocmd Syntax   clojure RainbowParenthesesLoadBraces



" remove vertical lines on window division
set fillchars+=vert:\

" Airline
let g:airline_powerline_fonts=0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode=1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#show_tabs=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#show_close_button=1


" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
" Turn off search highlight
nnoremap <silent> // :noh<CR>

" Movement
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

nnoremap $ <nop>
nnoremap ^ <nop>

" Backspace
set backspace=indent,eol,start

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Auto pairs shortcut
let g:AutoPairsShortcutFastWrap='<C-e>'

" NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.egg-info$', 'build$', 'dist$',
      \'__pycache__$']

" Neomake
"let g:neomake_javascript_enabled_makers=['eslint']
"call neomake#configure#automake('nw', 750)

nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current erro r/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning


" Tmux
let g:tmuxline_separators = {
      \ 'left' : '',
      \ 'left_alt': '|',
      \ 'right' : '',
      \ 'right_alt': '|',
      \ 'space': ' '}
"let g:tmuxline_theme = 'tomorrow'
" Repeat last command
nnoremap <Leader>r: call <SID>TmuxRepeat()<CR>

function! s:TmuxRepeat()
  silent! exec "!tmux select-pane -l && tmux send up enter && tmux select-pane -l"
  redraw!
endfunction

" TABS
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" Column
set textwidth=80
set colorcolumn=81
highlight ColorColumn ctermbg=darkgray

" Path
let &path.="src/include,/usr/include/AL,"

" Colors
syntax on

" Custom syntax
au BufRead,BufNewFile *.build setfiletype python
" Other
set autoread
if has('mouse')
  set mouse=a
endif
set encoding=utf8
set ffs=unix,dos,mac

" When scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Show whitespaces
set list
set listchars=tab:-→,eol:¬,extends:↩,precedes:↪,trail:·

" Autoreload
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Quit NERDTree
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
  "                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

" Minimal Vim
function! Minimal()
  set nolist
  set nonumber
  set showtabline=0
  set nocursorline
  set colorcolumn=0
  GitGutterDisable
  AirlineToggle
endfunction
command! Minimal call Minimal()

" Back to maximal vim
function! Maximal()
  set list
  set number
  set showtabline=2
  set cursorline
  set colorcolumn=81
  GitGutterEnable
  AirlineToggle
endfunction
command! Maximal call Maximal()

" GVIm
set guioptions-=m "remove menu bar
set guioptions-=T "remove tool bar
set guioptions-=r "remove scroll bar
set guioptions-=L "remove left scroll bar

set guifont=Hack\ Regular:h10

" PyRun
function! Python_Eval_VSplit() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":!python3 " . src . " > " . dst
  execute ":pedit! " . dst
endfunction
au BufNewFile,BufRead *.py vmap <F7> :call P

" Python
au BufNewFile, BufRead *.py
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set textwidth=79
      \ set expandtab
      \ set autoindent
      \ set fileformat=unix
      \ set colorcolumn=80
let python_highlight_all=1

"let g:neomake_python_python_maker = neomake#makers#ft#python#python()
"let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()

" Solidity
au BufNewFile, BufRead *.sol
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set expandtab
      \ set autoindent
      \ set fileformat=unix

"let g:neomake_solidity_enabled_makers=['solhint']

" Spell Checking
autocmd FileType tex,latex,md,txt setlocal spelllang=es_es spell


" Javascript
" Concealing characters
let g:javascript_conceal_function             = "λ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_arrow_function       = "🡺"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

let g:tigris#enabled = 1

highlight Conceal ctermbg=black ctermfg=cyan

let g:used_javascript_libs='ramda,jasmine,chai,react'

" Racket
autocmd filetype lisp,scheme,art setlocal equalprg=~/scmindent.rkt

" Clojure
map <leader>ar  :AcidRequire<CR>
map <leader>agd :AcidGoToDefinition<CR>

" C
let g:clighter_libclang_file = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" Clang
if has("nvim")
  let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
  let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
endif

" Notes
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'rename_file'


" Startup
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
"autocmd VimEnter * TagbarToggle
