set nocompatible
filetype off
" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'junegunn/goyo.vim'                  " Distraction free
Plug 'junegunn/limelight.vim'             " ditto
Plug 'scrooloose/nerdtree'                " NERD tree
Plug 'scrooloose/nerdcommenter'           " NERD Commenter <leader>cc
Plug 'Xuyuanp/nerdtree-git-plugin'        " NERD tree git plugin
Plug 'Townk/vim-autoclose'                " Auto pairs
Plug 'majutsushi/tagbar'                  " Tagbar
Plug 'mhinz/vim-startify'                 " Start screen
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'chriskempson/base16-vim'            " Color themes
Plug 'airblade/vim-gitgutter'             " Git +-
Plug 'vim-airline/vim-airline'            " Airline
Plug 'vim-airline/vim-airline-themes'     " Airline themes
Plug 'keith/tmux.vim'                     " TMUX
Plug 'edkolev/tmuxline.vim'               " TMUX line
"Plug 'PotatoesMaster/i3-vim-syntax'       " i3
Plug 'sheerun/vim-polyglot'               " Syntax highlighting
Plug 'justinmk/vim-syntax-extra'          " More Syntax highlighting
Plug 'justinmk/vim-sneak'                 " Motions
Plug 'ervandew/supertab'                  " Auto complete with Tab
"Plug 'eagletmt/neco-ghc'                  " Haskell autocomplete
Plug 'eraserhd/parinfer-rust'             " Lisp Parinfer
Plug 'guns/vim-sexp'                      " Lisp motions
Plug 'kien/rainbow_parentheses.vim'       " Rainbow parens
Plug 'Chiel92/vim-autoformat'             " Auto Formatting
Plug 'tpope/vim-sexp-mappings-for-regular-people' " Lisp-sexp mappings
Plug 'tpope/vim-surround'                 " Surround parens
Plug 'tpope/vim-fireplace'                " Clojure
Plug 'tpope/vim-endwise'                  " highlight matching blocks
Plug 'tpope/vim-unimpaired'               " Bracket mappings
Plug 'tpope/vim-commentary'               " comment with 'gc'
Plug 'tpope/vim-fugitive'                 " Git
Plug 'tpope/vim-repeat'                   " Repeat last command
Plug 'tpope/vim-dadbod'                   " Database interface
Plug 'tpope/vim-eunuch'                   " Unix commands
Plug 'tpope/vim-vinegar'                  " File explorer
Plug 'guns/vim-clojure-static'            " Clojure syntax
Plug 'guns/vim-clojure-highlight'         " Clojure syntax + fireplace
Plug 'morhetz/gruvbox'                    " Gruvbox colorscheme
Plug 'arcticicestudio/nord-vim'           " Nord colorscheme
Plug 'andymass/vim-matchup'               " Match blocks
Plug 'terryma/vim-smooth-scroll'          " Smooth scrolling
Plug 'tounaishouta/coq.vim'               " Coq proof assistant
" Only NeoVim and Vim8
if has("nvim") || (v:version >= 800)
  Plug 'Shougo/deoplete.nvim'               " Asynchronous autocomplete
  Plug 'w0rp/ale'                           " Lint
  Plug '/usr/local/opt/fzf'                 " Fuzzy finding filenames
  Plug 'junegunn/fzf.vim'
  Plug '/usr/local/opt/ripgrep'             " Better than ag
  Plug 'vim-pandoc/vim-pandoc'              " Markdown
  Plug 'vim-pandoc/vim-pandoc-syntax'       " Markdown syntax
  Plug 'prabirshrestha/async.vim'           " Async plugins
  Plug 'brooth/far.vim'                     " Search and replace project-wide
  Plug 'machakann/vim-highlightedyank'      " Highlight yank
  Plug 'l04m33/vlime', {'rtp': 'vim/'}      " Common Lisp
endif
if has('nvim')
  Plug 'neovim/nvim-lsp' " Language server protocol configurations. Only neovim
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

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Smooth Scrolling
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>

" Deoplete
if has("nvim")
  let g:ale_completion_enabled = 0
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_smart_case = 1
  let g:context_filetype#same_filetypes = {}
  let g:context_filetype#same_filetypes._ = '_'

  call deoplete#custom#option('sources', {
    \ '_': ['ale'],
  \})

  " call lsp#server#add('rust', ['rustup', 'run', 'nightly', 'rls'])
  " call lsp#server#add('python', 'pyls')
  " call lsp#server#add('typescript', {
  "       \ 'name': 'ts',
  "       \ 'callback': {
  "       \   'root_uri': { server -> RootFinderFromPlugin() }
  "       \ }})
  " call lsp#server#add('javascriptreact', ['flow', 'lsp'])
endif

" timeout
set ttimeout
set ttimeoutlen=0

" Update time
set updatetime=100

" Folding
set foldmethod=indent
set foldlevel=99

" mappings
map <F2> :NERDTreeToggle<CR>
map <F3> :TagbarToggle<CR>
nnoremap <leader><tab> :b#<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>a :Ag<CR>
nnoremap <silent> <leader>= :ALEFix<CR>
nnoremap <silent> <leader>ft :NERDTreeToggle<CR>
nnoremap <silent> <leader>n :ALENextWrap<CR>
nnoremap <silent> <leader>N :ALEPreviousWrap<CR>
nnoremap <silent> <leader>q :bd<CR>

nnoremap <silent> <leader>gd :GitGutterLineHighlightsToggle<CR>

" save session
nnoremap <leader>s :mksession<CR>

" UI
set nu
set showcmd
set wildmenu
set wildmode=list:longest,full
set showmatch
set ruler
set laststatus=2
set noshowmode
if has('nvim')
  set inccommand=nosplit
endif

set background=dark
let g:is_dark=0
function! ToggleDark()
  if g:is_dark
    let g:is_dark = 0
    set background=light
  else
    let g:is_dark = 1
    set background=dark
  endif
endfunction
nnoremap <leader>Tn :call ToggleDark()<CR>

if has("nvim")
  set termguicolors
  let base16colorspace=256
  let t_Co=256
  let g:airline_theme='gruvbox'
endif
if has("gui_running")
  set guifont=Iosevka-Custom-Light:h13
  set macligatures
  let g:airline_theme='gruvbox'
  autocmd! GUIEnter * set vb t_vb=
endif
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox

highlight Comment cterm=italic term=italic
set cursorline

" Rainbow Parens
if (has("nvim") || (v:version >= 800)) && !has("gui_running")
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
let g:airline_section_c='%>%f'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#fugitiveline#enabled=1
let g:airline#extensions#hunks#enabled=0
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

" Ignore these files
set wildignore+=*.zip,*.png,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,yarn.lock

" Sneak
let g:sneak#label = 1
let g:sneak#s_next = 1

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
let NERDTreeIgnore = [
      \'\.pyc$',
      \'\.o$',
      \'\.egg-info$',
      \'build$',
      \'dist$',
      \'__pycache__$',
      \'.out$',
      \'.aux$'
      \]

let g:NERDTreeMapOpenSplit = "-"
let g:NERDTreeMapOpenVSplit = "v"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
" let g:NERDTreeMapActivateNode = "l"

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

" Ctags executable
let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8_1/bin/ctags'

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
let g:used_javascript_libs='ramda,jasmine,chai,react,mocha,jest'
let g:javascript_plugin_flow=1

" Racket
autocmd filetype lisp,scheme,art setlocal equalprg=~/scmindent.rkt

" Clojure
map <leader>m' :FireplaceConnect<CR>

" C
let g:clighter_libclang_file = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" Clang
" if has("nvim")
"   let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
"   let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
" endif

" Rust
let g:ale_rust_rls_toolchain='nightly'
if executable('rls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
let g:ale_rust_rls_config = { 'rust': { 'clippy_preference': 'on' } }
let g:lsp_diagnostics_enabled = 1

" Forth
au BufNewFile, BufRead *.fs
      \ set syntax=forth

" ALE
let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'javascriptreact': ['eslint', 'prettier'],
      \ 'rust': ['rustfmt'],
      \ 'scala': ['scalafmt'],
      \ 'clojure': ['lein cljfmt fix']
  \}

let g:ale_linters = {
      \ 'rust': ['rls'],
      \ 'javascript': ['flow', 'eslint', 'prettier'],
      \ 'javascriptreact': ['flow', 'eslint', 'prettier'],
      \ 'scala': ['metals-vim'],
      \ 'sbt': ['metals-vim'],
      \ 'clojure': ['clojure-lsp', 'joker', 'clj-kondo']
      \ }
