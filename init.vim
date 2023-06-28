set nocompatible
filetype plugin indent on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"Load plugins
lua require("plugins")

" LSP config
nnoremap <silent> <C-c> <C-c> :ConjureEvalCurrentForm<CR>

inoremap <silent><expr> <C-Space> compe#complete()
set signcolumn=yes

" Neovide configuration
if exists("g:neovide")
  let g:neovide_refresh_rate=60
  let g:neovide_scroll_animation_length=0.1
  set guifont=PragmataPro\ Mono\ Liga:h16
endif

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
nnoremap <silent> <leader>ff <cmd>Telescope find_files<CR>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<CR>
nnoremap <silent> <leader>fa <cmd>Telescope live_grep<CR>
nnoremap <silent> <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <silent> <leader>fp <cmd>Telescope projects<CR>
nnoremap <silent> z= <cmd> Telescope spell_suggest<CR>
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
inoremap jk <Esc>

" save session
nnoremap <leader>s :mksession<CR>

" UI
set hidden
set signcolumn=yes
set cmdheight=2
set showtabline=0
set showcmd
set wildmenu
set wildmode=list:longest,full
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set ruler
set laststatus=3
set noshowmode
set diffopt+=linematch:60,algorithm:patience,vertical
set noeb
set inccommand=nosplit

" Status line
set statusline+=%{get(b:,'gitsigns_status','')}

" Line numbers
set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END

" Theme
set background=light

lua << EOF
  require("gruvbox").setup({
    contrast = "soft",
    bold = true,
    italic = {
      comments = true,
    },
  })
EOF
colorscheme gruvbox

set termguicolors
if has("gui_running")
  set guifont=PragmataPro\ Mono\ Liga:h16
  autocmd! GUIEnter * set vb t_vb=
endif

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
set wildignore+=*.zip,*.png,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,yarn.lock,package-lock.json

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qa_colors
  hi QuickScopePrimary guifg=#282828 guibg=#8ec07c gui=bold ctermfg=167 cterm=underline
  hi QuickScopeSecondary guifg=#282828 guibg=#fabd2f gui=bold ctermfg=214 cterm=underline
augroup END

hi! link LspInlayHint LspInfoTip

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
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set scrolloff=5
"set lazyredraw
set wildignorecase
set wrap

" Column
set textwidth=0  " don't autowrap text with newlines
set colorcolumn=80

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
  autocmd BufWritePost $MYVIMRC source $MYVIMRC :luafile $MYVIMRC
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
autocmd BufNewFile,BufRead *.fountain set filetype=md
autocmd filetype md,pandoc nmap gd <Plug>(pandoc-keyboard-links-open)
autocmd filetype md,pandoc setlocal sua+=.md
autocmd filetype md,pandoc setlocal spelllang=en_us
autocmd filetype md,pandoc setlocal spell

" Use FZF for z=
" function! FzfSpellSink(word)
"   exe 'normal! "_ciw'.a:word
" endfunction
" function! FzfSpell()
"   let suggestions = spellsuggest(expand("<cword>"))
"   return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10})
" endfunction
" nnoremap z= :call FzfSpell()<CR>

" ASDF projects
autocmd BufNewFile,BufRead *.asd set ft=lisp

" C
let g:clighter_libclang_file = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" Forth
au BufNewFile, BufRead *.fs set ft=forth

" Ocaml
let g:opamshare=substitute(system('opam config var share'), '\n$', '', '''')

" Open binary files with xxd
augroup Binary
  au!
  au BufReadPre  *.bin setlocal bin
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" Notional FZF
"let g:nv_search_paths = ['~/notes']

" Journaling
augroup JournalSyntax
  autocmd!
  autocmd BufReadPost ~/journal/* set filetype=journal syntax=journal
augroup END


" Lua functions
lua require('init')

augroup packer_user_config
 autocmd!
 autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
