set nocompatible
filetype off
" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdcommenter'           " NERD Commenter <leader>cc
Plug 'jiangmiao/auto-pairs'               " Auto pair
Plug 'mhinz/vim-startify'                 " Start screen
Plug 'airblade/vim-rooter'                " Make project directory as root
" Plug 'keith/tmux.vim'                     " TMUX
" Plug 'edkolev/tmuxline.vim'               " TMUX line
" Plug 'justinmk/vim-sneak'                 " Motions
Plug 'wellle/targets.vim'                 " More targets
" Lisp parinfer
Plug 'eraserhd/parinfer-rust', {'for': ['clojure', 'scheme', 'racket', 'common lisp']}
Plug 'guns/vim-sexp'                      " Lisp motions
Plug 'tpope/vim-sexp-mappings-for-regular-people' " Lisp-sexp mappings
Plug 'tpope/vim-surround'                 " Surround parens
Plug 'tpope/vim-endwise'                  " highlight matching blocks
Plug 'tpope/vim-unimpaired'               " Bracket mappings
Plug 'tpope/vim-commentary'               " comment with 'gc'
Plug 'tpope/vim-fugitive'                 " Git
Plug 'tpope/vim-repeat'                   " Repeat last command
Plug 'tpope/vim-eunuch'                   " Unix commands
"Plug 'arcticicestudio/nord-vim'           " Nord theme
"Plug 'yonlu/omni.vim'                     " Omni theme
"Plug 'cocopon/iceberg.vim'                " Iceberg theme
"Plug 'dracula/vim'                        " Dracula theme
Plug 'andymass/vim-matchup'               " Match blocks
Plug 'vimwiki/vimwiki'                    " Wiki on vim
"Plug 'vifm/vifm.vim'                      " File browser
Plug 'bakpakin/fennel.vim'                " Fennel syntax highlightning
Plug 'unblevable/quick-scope'             " Show motions
Plug 'neoclide/jsonc.vim'                 " Allow comments in JSON
"Plug 'BeneCollyridam/futhark-vim'         " Futhark
Plug 'dbakker/vim-projectroot'            " Find the root of the project
Plug 'samoshkin/vim-mergetool'            " Merge tool
Plug 'machakann/vim-highlightedyank'      " Highlight yank
Plug 'chaoren/vim-wordmotion'             " Word motions work with camelcase
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finding filenames
" FZF
Plug 'junegunn/fzf.vim', { 'on': ['Files', 'Buffers', 'Rg'] }
Plug '/usr/local/opt/ripgrep'             " Better than ag
Plug 'vim-pandoc/vim-pandoc'              " Markdown
Plug 'vim-pandoc/vim-pandoc-syntax'       " Markdown syntax
Plug 'prabirshrestha/async.vim'           " Async plugins
Plug 'vim-scripts/dbext.vim'              " Database access
Plug 'Olical/conjure', { 'for': 'clojure'} " Clojure eval
Plug 'pantharshit00/vim-prisma'           " Prisma syntax
Plug 'alok/notational-fzf-vim'            " Notational velocity
Plug '2072/PHP-Indenting-for-VIm'         " fix php identation issues
Plug 'rescript-lang/vim-rescript'         " Rescript language
Plug 'towolf/vim-helm'                    " Helm templates
Plug 'chrisbra/unicode.vim'               " Unicode search
if has('nvim')
  Plug 'neovim/nvim-lspconfig' " Language server protocol configurations. Only neovim

  Plug 'hrsh7th/cmp-nvim-lsp'               " Autocomplete
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'liuchengxu/vista.vim'               " View tags
  Plug 'Olical/aniseed'                     " Fennel neovim config
  Plug 'petertriho/nvim-scrollbar'          " Scrollbar with diagnostics
  Plug 'APZelos/blamer.nvim'                " Git blame
  Plug 'lewis6991/gitsigns.nvim'            " Better, faster gitgutter
  Plug 'nvim-treesitter/nvim-treesitter'    " Code highlight
  Plug 'nvim-treesitter/nvim-treesitter-textobjects' " Textobjects
  "Plug 'p00f/nvim-ts-rainbow'               " Rainbowparens
  Plug 'ojroques/nvim-lspfuzzy', {'branch': 'main'} " Lsp search displays in FZF
  Plug 'gfanto/fzf-lsp.nvim'                 " FZF on definitions
  Plug 'nvim-lua/plenary.nvim'               " Lua functions
  Plug 'nvim-lua/popup.nvim'                 " Popup windows
  "Plug 'romgrk/barbar.nvim'                  " Tabbar
  "Plug 'RRethy/nvim-base16'                  " Base16 themes
  Plug 'hoob3rt/lualine.nvim'                " Lua statusline
  " Tree viewer
  Plug 'kyazdani42/nvim-tree.lua', { 'on': 'NvimTreeToggle' }
  "Plug 'kosayoda/nvim-lightbulb'             " Code action lightbulb emoji
  Plug 'norcalli/nvim-colorizer.lua'         " Color preview
  Plug 'jose-elias-alvarez/null-ls.nvim'     " Language Server for linters
  Plug 'stevearc/dressing.nvim'              " Better UI
  Plug 'ggandor/leap.nvim'                   " Motions
  Plug 'SmiteshP/nvim-gps'                   " Show AST cursor
  Plug 'ggandor/leap-ast.nvim'               " Hop around AST
  Plug 'folke/lsp-colors.nvim'

  " LSP config
  nnoremap <silent> <C-c> <C-c> :ConjureEvalCurrentForm<CR>

  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <C-k> pumvisible() ? "\<Up>" : "\<C-k>"
  inoremap <silent><expr> <C-j> pumvisible() ? "\<Down>" : "\<C-j>"

  set signcolumn=yes

  "autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()

  Plug 'ellisonleao/gruvbox.nvim'           " Gruvbox colorscheme
else
  Plug 'morhetz/gruvbox'                    " Gruvbox colorscheme
endif

call plug#end()
filetype plugin indent on

" Neovide configuration
if exists("g:neovide")
  let g:neovide_refresh_rate=60
  let g:neovide_scroll_animation_length=0.1
  set guifont=PragmataPro\ Mono\ Liga:h16
endif

" NVIM
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Space is leader key
nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

" Startify
let g:startify_custom_header =
      \ map(split(system('todo.sh'), '\n'), '"   ". v:val')

" Completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menu,menuone,noselect
set shortmess+=c

set clipboard=unnamedplus

" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

" mappings
map <F2> :Fern . -drawer -reveal=% -toggle <CR>
nnoremap <leader><tab> :b#<CR>
" nnoremap <leader>tt :tabnew<CR>
" nnoremap <leader>tn :tabnext<CR>
" nnoremap <leader>tp :tabprevious<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>aa :Rg<CR>
nnoremap <silent> <leader>ft :NvimTreeToggle <CR>
nnoremap <silent> <leader>q :bd<CR>
vnoremap <silent> . :norm . <CR>
nnoremap <C-s> :%s//g<Left><Left>
nnoremap <leader>gs :G <CR>
" nnoremap <C-j> 3<C-e>
" nnoremap <C-k> 3<C-y>
nnoremap <f1> <nop>
inoremap <f1> <nop>
nnoremap <leader>t :enew<CR>
nnoremap <M-q> :b1<CR>
nnoremap <M-w> :b2<CR>
nnoremap <M-e> :b3<CR>
nnoremap <M-r> :b4<CR>
nnoremap <M-t> :b5<CR>

" save session
nnoremap <leader>s :mksession<CR>

inoremap jk <Esc>

" UI
set hidden
set signcolumn=yes
set cmdheight=2
set showtabline=0
set showcmd
set wildmenu
set wildmode=list:longest,full
set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20
set ruler
set laststatus=3
set noshowmode
if has('nvim')
  set inccommand=nosplit
endif

" Status line
set statusline+=%{get(b:,'gitsigns_status','')}

" Line numbers
set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END

"if strftime("%H") < 18
if 0
  set background=light
  let $BAT_THEME="gruvbox-light"
  let $FZF_DEFAULT_OPTS="
        \ --color=fg:#3c3836,bg:#f2e5bc,hl:#458588
        \ --color=fg+:#282828,bg+:#fbf1c7,hl+:#076678
        \ --color=info:#d79921,prompt:#cc241d,pointer:#b16286
        \ --color=marker:#98971a,spinner:#b16286,header:#7c6f64"
  lua require("gruvbox").setup({ contrast = "soft" })

else
  set background=dark
  let $BAT_THEME="gruvbox-dark"
  let $FZF_DEFAULT_OPTS="
        \ --color=fg:#ebdbb2,bg:#282828,hl:#458588
        \ --color=fg+:#f2e5bc,bg+:#32302f,hl+:#076678
        \ --color=info:#d79921,prompt:#cc241d,pointer:#b16286
        \ --color=marker:#98971a,spinner:#b16286,header:#7c6f64"
  lua require("gruvbox").setup({ contrast = "hard" })
endif

colorscheme gruvbox

if has("nvim")
  set termguicolors
endif
if has("gui_running")
  set guifont=PragmataPro\ Mono\ Liga:h16
  autocmd! GUIEnter * set vb t_vb=
endif
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_style='night'

hi Comment cterm=italic term=italic gui=italic guifg=DarkGray

" Neovide config
let g:neovide_cursor_animation_length=0

" Cursorline
set cursorline

" Search
set incsearch
set hlsearch is
set ignorecase
set smartcase
set showmatch
set path=**

" Turn off search highlight
nnoremap <silent> // :noh<CR>

" Ignore these files
set wildignore+=*.zip,*.png,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,yarn.lock

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qa_colors
  hi QuickScopePrimary guifg=#282828 guibg=#8ec07c gui=bold ctermfg=167 cterm=underline
  hi QuickScopeSecondary guifg=#282828 guibg=#fabd2f gui=bold ctermfg=214 cterm=underline
augroup END

" Sneak
" let g:sneak#label = 1
" let g:sneak#s_next = 1
" let g:sneak#use_ic_scs = 1 "Case insensitive
" augroup sneak_colors
"   hi Sneak guifg=#282828 guibg=#fb4934 gui=bold ctermfg=black ctermbg=cyan
"   hi SneakScope guifg=#282828 guibg=#8ec07c gui=bold ctermfg=red ctermbg=yellow
"   hi SneakLabel guifg=#282828 guibg=#fabd2f gui=bold
" augroup END

" Movement
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

nnoremap $ <nop>
nnoremap ^ <nop>

" better indenting
vnoremap < <gv
vnoremap > >gv

" Auto pairs shortcut
let g:AutoPairsShortcutFastWrap='<C-e>'

" Editor
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab
set scrolloff=5
set lazyredraw
set wildignorecase
set wrap


" Column
set textwidth=80
set colorcolumn=81

" Path
let &path.="src/include,/usr/include/AL,"

" Colors
syntax on

" Custom syntax
au BufRead,BufNewFile *.build setfiletype python
au BufRead,BufNewFile *.s setfiletype nasm

" Other
set autoread
if has('mouse')
  set mouse=a
endif

" System
set encoding=utf8
set nobackup
set noswapfile
set ffs=unix,dos,mac
set updatetime=250
set undofile
"let &undodir=s:cnull.config.undodir
set undolevels=10000
set history=10000
set backspace=indent,eol,start
set ttimeout
set ttimeoutlen=0

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

" GVIm
set guioptions-=m "remove menu bar
set guioptions-=T "remove tool bar
set guioptions-=r "remove scroll bar
set guioptions-=L "remove left scroll bar

" Rust
let g:rust_recommended_style=0

" Spell Checking
autocmd filetype tex,latex,md,txt,wiki,pandoc setlocal spelllang=es spell complete+=kspell

" Markdown
autocmd filetype md,pandoc nmap gd <Plug>(pandoc-keyboard-links-open)
autocmd filetype md,pandoc setlocal sua+=.md

" Use FZF for z=
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10})
endfunction
nnoremap z= :call FzfSpell()<CR>

" ASDF projects
autocmd BufNewFile,BufRead *.asd set ft=lisp

" C
let g:clighter_libclang_file = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" Forth
au BufNewFile, BufRead *.fs set ft=forth

" Ocaml
let g:opamshare=substitute(system('opam config var share'), '\n$', '', '''')

" Notional FZF
let g:nv_search_paths = ['~/notes']

" Vimwiki
let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Lua functions
if has('nvim')
   lua require('init')
endif
