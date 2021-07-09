set nocompatible
filetype off
" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdcommenter'           " NERD Commenter <leader>cc
Plug 'jiangmiao/auto-pairs'               " Auto pair
Plug 'mhinz/vim-startify'                 " Start screen
Plug 'airblade/vim-rooter'                " Make project directory as root
Plug 'keith/tmux.vim'                     " TMUX
Plug 'edkolev/tmuxline.vim'               " TMUX line
Plug 'sheerun/vim-polyglot'               " Syntax highlighting
Plug 'justinmk/vim-syntax-extra'          " More Syntax highlighting
Plug 'justinmk/vim-sneak'                 " Motions
Plug 'wellle/targets.vim'                 " More targets
Plug 'eraserhd/parinfer-rust'             " Lisp Parinfer
Plug 'guns/vim-sexp'                      " Lisp motions
Plug 'tpope/vim-sexp-mappings-for-regular-people' " Lisp-sexp mappings
Plug 'tpope/vim-surround'                 " Surround parens
Plug 'tpope/vim-endwise'                  " highlight matching blocks
Plug 'tpope/vim-unimpaired'               " Bracket mappings
Plug 'tpope/vim-commentary'               " comment with 'gc'
Plug 'tpope/vim-fugitive'                 " Git
Plug 'tpope/vim-repeat'                   " Repeat last command
Plug 'tpope/vim-eunuch'                   " Unix commands
Plug 'morhetz/gruvbox'                    " Gruvbox colorscheme
Plug 'arcticicestudio/nord-vim'           " Nord theme
Plug 'yonlu/omni.vim'                     " Omni theme
Plug 'dracula/vim'                        " Dracula theme
Plug 'andymass/vim-matchup'               " Match blocks
Plug 'vimwiki/vimwiki'                    " Wiki on vim
Plug 'vifm/vifm.vim'                      " File browser
Plug 'bakpakin/fennel.vim'                " Fennel syntax highlightning
Plug 'unblevable/quick-scope'             " Show motions
Plug 'neoclide/jsonc.vim'                 " Allow comments in JSON
Plug 'BeneCollyridam/futhark-vim'         " Futhark
Plug 'dbakker/vim-projectroot'            " Find the root of the project
Plug 'samoshkin/vim-mergetool'            " Merge tool
Plug 'machakann/vim-highlightedyank'      " Highlight yank
Plug 'chaoren/vim-wordmotion'             " Word motions work with camelcase
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finding filenames
Plug 'Olical/aniseed'                       " Fennel neovim config
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/ripgrep'             " Better than ag
Plug 'vim-pandoc/vim-pandoc'              " Markdown
Plug 'vim-pandoc/vim-pandoc-syntax'       " Markdown syntax
Plug 'prabirshrestha/async.vim'           " Async plugins
Plug 'brooth/far.vim'                     " Search and replace project-wide
Plug 'l04m33/vlime', {'rtp': 'vim/'}      " Common Lisp
Plug 'APZelos/blamer.nvim'                " Git blame
Plug 'vim-scripts/dbext.vim'              " Database access
if has('nvim')
  Plug 'neovim/nvim-lspconfig' " Language server protocol configurations. Only neovim
  Plug 'hrsh7th/nvim-compe'                 " Autocomplete
  Plug 'lewis6991/gitsigns.nvim'            " Better, faster gitgutter
  Plug 'nvim-treesitter/nvim-treesitter'    " Code highlight
  Plug 'nvim-treesitter/nvim-treesitter-textobjects' " Textobjects
  Plug 'p00f/nvim-ts-rainbow'               " Rainbowparens
  Plug 'ojroques/nvim-lspfuzzy', {'branch': 'main'} " Lsp search displays in FZF
  Plug 'nvim-lua/plenary.nvim'               " Lua functions
  Plug 'nvim-lua/popup.nvim'                 " Popup windows
  Plug 'romgrk/barbar.nvim'                  " Tabbar
  Plug 'RRethy/nvim-base16'                  " Base16 themes
  Plug 'hoob3rt/lualine.nvim'                " Lua statusline
  Plug 'kyazdani42/nvim-tree.lua'            " Tree viewer
  Plug 'kosayoda/nvim-lightbulb'             " Code action lightbulb emoji
  Plug 'creativenull/diagnosticls-nvim'      " Diagnostics with linters and formatters

  " LSP config
  nnoremap <leader> gd        <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> <space>l  <cmd>lua vim.lsp.codelens.display()<CR>
  nnoremap <silent> <space>re <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> gd        <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
  " nnoremap <silent> <leader>n <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
  " nnoremap <silent> <leader>N <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap <silent> <c-a>     <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <silent> <space>= <cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>

  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <C-k> pumvisible() ? "\<Up>" : "\<C-k>"
  inoremap <silent><expr> <C-j> pumvisible() ? "\<Down>" : "\<C-j>"

  set updatetime=300
  set signcolumn=yes

  "autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()

endif
call plug#end()
filetype plugin indent on

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
set completeopt=menuone,noselect
set shortmess+=c

set clipboard=unnamedplus

" timeout
set ttimeout
set ttimeoutlen=0

" Update time
set updatetime=100

" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

let g:nvim_tree_show_icons = {
      \ 'git': 1,
      \ 'folders': 0,
      \ 'files': 0,
      \ }

" mappings
map <F2> :Fern . -drawer -reveal=% -toggle <CR>
nnoremap <leader><tab> :b#<CR>
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader>aa :Rg<CR>
nnoremap <silent> <leader>ft :NvimTreeToggle <CR>
nnoremap <silent> <leader>q :bd<CR>
vnoremap <silent> . :norm . <CR>
nnoremap <C-s> :%s//g<Left><Left>
nnoremap <leader>gs :G <CR>
nnoremap <C-j> 3<C-e>
nnoremap <C-k> 3<C-y>
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

" Status line
set statusline+=%{get(b:,'gitsigns_status','')}

" Line numbers
set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END

hi CursorLine cterm=underline term=underline

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

highlight Comment cterm=italic term=italic
if has("nvim")
  set termguicolors
  let base16colorspace=256
  let t_Co=256
  "let g:airline_theme='dracula'
  colorscheme dracula
endif
set guifont=PragmataPro\ Mono\ Liga:h16
if has("gui_running")
  colorscheme dracula
  let g:airline_theme='dracula'
  autocmd! GUIEnter * set vb t_vb=
endif
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_italic=1
let g:gruvbox_bold=1

" barbar
let bufferline = get(g:, 'bufferline', {})
let bufferline.closable = v:false
let bufferline.maximum_padding = 1
let bufferline.icons = v:false

" Neovide config
let g:neovide_cursor_animation_length=0

" Cursorline
set cursorline
" Search
set incsearch
set hlsearch is
set ignorecase
set smartcase
" Turn off search highlight
nnoremap <silent> // :noh<CR>

" Ignore these files
set wildignore+=*.zip,*.png,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,yarn.lock

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qa_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#fb4934' gui=underline ctermfg=167 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#fabd2f' gui=underline ctermfg=214 cterm=underline
augroup END

" Sneak
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1 "Case insensitive
highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

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

" Backspace
set backspace=indent,eol,start

" Auto pairs shortcut
let g:AutoPairsShortcutFastWrap='<C-e>'

" NVim Tree
let g:nvim_tree_gitignore=1
let g:nvim_tree_auto_open=1
let g:nvim_tree_git_hl=1
let g:nvim_tree_lsp_diagnostics=1
let g:nvim_tree_hijack_netrw=0
let g:nvim_tree_disable_netrw=0

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
au BufRead,BufNewFile *.s setfiletype nasm

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

" GVIm
set guioptions-=m "remove menu bar
set guioptions-=T "remove tool bar
set guioptions-=r "remove scroll bar
set guioptions-=L "remove left scroll bar

" Rust
let g:rust_recommended_style=0

" Spell Checking
autocmd filetype tex,latex,md,txt,wiki setlocal spelllang=es spell complete+=kspell

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

" Lua functions
if has('nvim')
   "lua require('aniseed.env').init({ module = 'dotfiles.init' })
   lua require('init')
endif
