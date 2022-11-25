vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'scrooloose/nerdcommenter'           -- Nerdcommenter
  use 'mhinz/vim-startify'                 -- Start screen
  use 'airblade/vim-rooter'                -- Make project directory as root
  use 'wellle/targets.vim'                 -- More targets
  ---- Lisp parinfer
  use {
    'eraserhd/parinfer-rust',
    ft = {'clojure', 'scheme', 'racket', 'common lisp'}
  }
  use 'guns/vim-sexp'                      -- Lisp motions
  use 'tpope/vim-sexp-mappings-for-regular-people' -- Lisp-sexp mappings
  use 'tpope/vim-surround'                 -- Surround parens
  use 'tpope/vim-endwise'                  -- highlight matching blocks
  use 'tpope/vim-unimpaired'               -- Bracket mappings
  use 'tpope/vim-commentary'               -- comment with 'gc'
  use 'tpope/vim-fugitive'                 -- Git
  use 'tpope/vim-repeat'                   -- Repeat last command
  use 'tpope/vim-eunuch'                   -- Unix commands
  use 'rstacruz/vim-closer'                -- Auto close parens
  use 'andymass/vim-matchup'               -- Match blocks
  use 'vimwiki/vimwiki'                    -- Wiki on vim
  use 'bakpakin/fennel.vim'                -- Fennel syntax highlightning
  use 'unblevable/quick-scope'             -- Show motions
  use 'neoclide/jsonc.vim'                 -- Allow comments in JSON
  use 'dbakker/vim-projectroot'            -- Find the root of the project
  use 'samoshkin/vim-mergetool'            -- Merge tool
  use 'machakann/vim-highlightedyank'      -- Highlight yank
  use 'chaoren/vim-wordmotion'             -- Word motions work with camelcase
  -- Fuzzy finding filenames
  use {
    'junegunn/fzf',
    run = function () vim.fn('fzf#install()') end
  }
  -- FZF
  use {
    'junegunn/fzf.vim',
    cmd = {'Files', 'Buffers', 'Rg' }
  }
  use '/usr/local/opt/ripgrep'             -- Better than ag
  use 'vim-pandoc/vim-pandoc'              -- Markdown
  use 'vim-pandoc/vim-pandoc-syntax'       -- Markdown syntax
  use 'prabirshrestha/async.vim'           -- Async plugins
  use {                                    -- Clojure eval
    'Olical/conjure',
    ft = {'clojure'},
  }
  use 'pantharshit00/vim-prisma'           -- Prisma syntax
  use 'alok/notational-fzf-vim'            -- Notational velocity
  use '2072/PHP-Indenting-for-VIm'         -- fix php identation issues
  use 'rescript-lang/vim-rescript'         -- Rescript language
  use 'towolf/vim-helm'                    -- Helm templates
  use 'chrisbra/unicode.vim'               -- Unicode search
  use 'neovim/nvim-lspconfig'              -- Language server protocol configurations.
  use 'hrsh7th/cmp-nvim-lsp'               -- Autocomplete
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'liuchengxu/vista.vim'               -- View tags
  use 'Olical/aniseed'                     -- Fennel neovim config
  use 'petertriho/nvim-scrollbar'          -- Scrollbar with diagnostics
  use 'APZelos/blamer.nvim'                -- Git blame
  use 'lewis6991/gitsigns.nvim'            -- Better, faster gitgutter
  use {                                    -- Code highlight
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Textobjects
  use 'p00f/nvim-ts-rainbow'               -- Rainbowparens
  use {                                    -- Lsp search displays in FZF
    'ojroques/nvim-lspfuzzy',
    branch = 'main',
  }
  use 'gfanto/fzf-lsp.nvim'                 -- FZF on definitions
  use 'nvim-lua/plenary.nvim'               -- Lua functions
  use 'nvim-lua/popup.nvim'                 -- Popup windows
  --use 'romgrk/barbar.nvim'                  -- Tabbar
  use 'RRethy/nvim-base16'                  -- Base16 themes
  use 'hoob3rt/lualine.nvim'                -- Lua statusline
  -- Tree viewer
  use {
    'kyazdani42/nvim-tree.lua',
    --cmd = {'NvimTreeToggle' },
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  }
  use 'kosayoda/nvim-lightbulb'             -- Code action lightbulb emoji
  use 'norcalli/nvim-colorizer.lua'         -- Color preview
  use 'jose-elias-alvarez/null-ls.nvim'     -- Language Server for linters
  use 'stevearc/dressing.nvim'              -- Better UI
  use 'ggandor/leap.nvim'                   -- Motions
  use 'SmiteshP/nvim-gps'                   -- Show AST cursor
  use 'ggandor/leap-ast.nvim'               -- Hop around AST
  use 'folke/lsp-colors.nvim'
  use 'ellisonleao/gruvbox.nvim'            -- Gruvbox colorscheme
  use 'L3MON4D3/LuaSnip'                    -- Snippets engine
end)
