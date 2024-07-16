local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
  "stevearc/dressing.nvim",   -- UI improvements
  "lewis6991/impatient.nvim", -- Speed up startup
  "chentoast/marks.nvim",     -- Marks
  "mhinz/vim-startify",       -- Start screen
  "airblade/vim-rooter",      -- Make project directory as root
  "wellle/targets.vim",       -- More targets
  "Darazaki/indent-o-matic",  -- Indentation
  ---- Lisp parinfer
  {
    "eraserhd/parinfer-rust",
    ft = { "clojure", "scheme", "racket", "common lisp", "dune" },
    build = "cargo build --release",
  },
  "guns/vim-sexp",                              -- Lisp motions
  "tpope/vim-sexp-mappings-for-regular-people", -- Lisp-sexp mappings
  --"kovisoft/slimv",                             -- Lisp repl
  "rhysd/reply.vim",                             -- Lisp repl
  "tpope/vim-surround",                         -- Surround parens
  "tpope/vim-endwise",                          -- highlight matching blocks
  "rstacruz/vim-closer",                        -- Auto close parens
  "tpope/vim-unimpaired",                       -- Bracket mappings
  "tpope/vim-fugitive",                         -- Git
  "tpope/vim-repeat",                           -- Repeat last command
  "tpope/vim-eunuch",                           -- Unix commands
  "andymass/vim-matchup",                       -- Match blocks
  "vimwiki/vimwiki",                            -- Wiki on vim
  "neoclide/jsonc.vim",                         -- Allow comments in JSON
  "machakann/vim-highlightedyank",              -- Highlight yank
  "chaoren/vim-wordmotion",                     -- Word motions work with camelcase
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },                                         -- Fuzzy finding
  "nvim-telescope/telescope-ui-select.nvim", -- Use telescope for actions
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  --"/usr/local/opt/ripgrep",       -- Better than ag
  "vim-pandoc/vim-pandoc",        -- Markdown
  "vim-pandoc/vim-pandoc-syntax", -- Markdown syntax
  "towolf/vim-helm",              -- Helm templates
  "chrisbra/unicode.vim",         -- Unicode search
  "neovim/nvim-lspconfig",        -- Language server protocol configurations.
  "hrsh7th/cmp-nvim-lsp",         -- Autocomplete
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/nvim-cmp",
  "petertriho/nvim-scrollbar", -- Scrollbar with diagnostics
  "APZelos/blamer.nvim",       -- Git blame
  "lewis6991/gitsigns.nvim",   -- Better, faster gitgutter
  {
    -- Code highlight
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-textobjects", -- Textobjects
  --"hiphish/rainbow-delimiters.nvim", -- Rainbow parens
  "nvim-treesitter/nvim-treesitter-context", -- Context
  {  -- Lsp search displays in FZF
    "ojroques/nvim-lspfuzzy",
    branch = "main",
  },
  "nvim-lua/plenary.nvim", -- Lua functions
  "hoob3rt/lualine.nvim",  -- Lua statusline
  -- Tree viewer
  {
    "kyazdani42/nvim-tree.lua",
    --cmd = {'NvimTreeToggle' },
    tag = "nightly",                          -- optional, updated every week. (see issue #1193)
  },
  "norcalli/nvim-colorizer.lua",              -- Color preview
  "mfussenegger/nvim-lint",                   -- Linting
  "mhartington/formatter.nvim",               -- Formatter
  "ggandor/leap.nvim",                        -- Motions
  "ggandor/leap-ast.nvim",                    -- Hop around AST
  --"unblevable/quick-scope",                   -- Highlight jump targets
  "ellisonleao/gruvbox.nvim",                 -- Gruvbox colorscheme
  "sainnhe/everforest",                       -- Everforest colorscheme
  { "catppuccin/nvim", name = "catppuccin" }, -- Color scheme
  "L3MON4D3/LuaSnip",                         -- Snippets engine
  "github/copilot.vim",                       -- Github Copilot
  "powerman/vim-plugin-AnsiEsc",              -- Ansi escape sequences
  "nacro90/numb.nvim",                        -- Peek lines
  "rescript-lang/vim-rescript",               -- Rescript
  "edwinb/idris2-vim"                         -- Idris 2
})
