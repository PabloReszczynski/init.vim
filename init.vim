set nocompatible
filetype off
" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'                " NERD tree
Plug 'scrooloose/nerdcommenter'           " NERD Commenter <leader>cc
Plug 'jiangmiao/auto-pairs'               " Auto pairs
Plug 'majutsushi/tagbar'                  " Tagbar
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'chriskempson/base16-vim'            " base16 themes
Plug 'airblade/vim-gitgutter'             " Git +-
Plug 'vim-airline/vim-airline'            " Airline
Plug 'vim-airline/vim-airline-themes'     " Airline themes
Plug 'keith/tmux.vim'                     " TMUX
Plug 'PotatoesMaster/i3-vim-syntax'       " i3
Plug 'kien/ctrlp.vim'                     " Fuzzy Finder
Plug 'monokrome/vim-testdrive'            " Test Runner for Vim
Plug 'jgdavey/tslime.vim'                 " Send to tmux
Plug 'tpope/vim-dispatch'                 " Dispatch proceses
Plug 'tpope/vim-fugitive'                 " Git support
Plug 'sheerun/vim-polyglot'               " Syntax highlighting
Plug 'ervandew/supertab'                  " Auto complete with Tab
Plug 'rking/ag.vim'                       " Project Search
Plug 'Twinside/vim-haskellConceal'        " Haskell conceal
Plug 'eagletmt/neco-ghc'                  " Haskell autocomplete
Plug 'xolox/vim-notes'                    " Take notes in vim
Plug 'xolox/vim-misc'                     " Dependency of vim-notes
Plug 'kien/rainbow_parentheses.vim'       " Rainbow parens for lisp
" Only NeoVim
Plug 'Shougo/deoplete.nvim'               " Asynchronous autocomplete
Plug 'zchee/deoplete-jedi'                " Async Python autocomplete
Plug 'neomake/neomake'                    " Like Syntastic
call plug#end()
filetype plugin indent on

" PATH
let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" NVIM
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Comma is leader key
let mapleader = ","

" Deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#sources={}
let g:deoplete#sources._=['buffer', 'tag', 'file']

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

set termguicolors
let base16colorspace=256
let t_Co=256
let g:airline_theme='base16'
colorscheme base16-nord

highlight Comment cterm=italic term=italic

" Airline
let g:airline_powerline_fonts=0
let g:airline#extensions#branch#enabled=1
"let g:airline_enable_syntastic=1
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tabline#enabled=1

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
" Turn off search highlight
nnoremap <C-l> :nohl<CR><C-l>

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
let NERDTreeIgnore = ['\.pyc$', '\.o$']

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_generic = 1
"let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'

" TestDriver
let g:testdrive#use_dispatch=1
let g:testdrive#always_open_results=1

" Tmux
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
let g:deoplete#enable_at_startup = 1

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

highlight Conceal ctermbg=black ctermfg=cyan

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = "~/.config/nvim/.ycm_extra_conf.py"
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" Racket
autocmd filetype lisp,scheme,art setlocal equalprg=~/scmindent.rkt

" Clojure
map <leader>ar  :AcidRequire<CR>
map <leader>agd :AcidGoToDefinition<CR>

" Notes
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'rename_file'

" Startup
"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
"autocmd VimEnter * TagbarToggle
