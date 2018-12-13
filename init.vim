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
Plug 'ervandew/supertab'                  " Auto complete with Tab
Plug 'rking/ag.vim'                       " Project Search
Plug 'eagletmt/neco-ghc'                  " Haskell autocomplete
Plug 'eraserhd/parinfer-rust'             " Lisp Parinfer
Plug 'kien/rainbow_parentheses.vim'       " Rainbow parens
Plug 'Chiel92/vim-autoformat'             " Auto Formatting
Plug 'tpope/vim-fireplace'                " Clojure
Plug 'guns/vim-clojure-static'            " Clojure syntax
Plug 'guns/vim-clojure-highlight'         " Clojure syntax + fireplace
Plug 'tpope/vim-unimpaired'               " Bracket mappings
Plug 'tpope/vim-commentary'               " comment with 'gc'
Plug 'junegunn/goyo.vim'                  " Distraction free
Plug 'junegunn/limelight.vim'             " ditto
Plug 'morhetz/gruvbox'                    " Gruvbox colorscheme
" Only NeoVim and Vim8
if has("nvim") || (v:version >= 800)
Plug 'Shougo/deoplete.nvim'               " Asynchronous autocomplete
Plug 'Shougo/neoinclude.vim'              " Autocomplete header files
Plug 'Shougo/context_filetype.vim'        " Other file autocompletion
Plug 'zchee/deoplete-jedi'                " Async Python autocomplete
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } "JS
Plug 'zchee/deoplete-clang'               " C, C++ autocompletion
Plug 'w0rp/ale'                           " Lint
Plug '/usr/local/opt/fzf'                 " Fuzzy finding
Plug 'vim-pandoc/vim-pandoc'              " Markdown
Plug 'vim-pandoc/vim-pandoc-syntax'       " Markdown syntax
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
  let g:deoplete#auto_complete_start_length = 1
  "let g:deoplete#sources={}
  "let g:deoplete#sources._=['buffer', 'tag', 'file']
  "let g:tern#filetypes = ['jsx']
  let g:deoplete#complete_method="complete"
  "“ Map expression when a tab is hit:
  "“           checks if the completion popup is visible
  "“           if yes
  "“               then it cycles to next item
  "“           else
  "“               if expandable_or_jumpable
  "“                   then expands_or_jumps
  "“                   else returns a normal TAB
  imap <expr><TAB>
        \ pumvisible() ? "\<C-n>" :
        \ neosnippet#expandable_or_jumpable() ?
        \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  "“ Expands or completes the selected snippet/item in the popup menu
  imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
        \ "\<Plug>(neosnippet_jump_or_expand)" : "\<CR>"
  smap <silent><CR> <Plug>(neosnippet_jump_or_expand)

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
map <leader><tab> :b#<CR>
map <leader>bb :FZF<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag

" UI
set nu
set showcmd
set wildmenu
set wildmode=list:longest,full
set showmatch
set ruler
set laststatus=2

set background=dark

if has("nvim")
  set termguicolors
  let base16colorspace=256
  let t_Co=256
  let g:airline_theme='base16'
endif
if has("gui_running")
  set guifont=Iosevka:h16
  let g:airline_theme='gruvbox'
endif
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox

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
let g:airline#extensions#ale#enabled=1


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
  set showtabline=0
  set nocursorline
  set colorcolumn=0
  Goyo 120
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

" Solidity
au BufNewFile, BufRead *.sol
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set expandtab
      \ set autoindent
      \ set fileformat=unix

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
