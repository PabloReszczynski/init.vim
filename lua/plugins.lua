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
  -- Better marks
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup()
    end
  },
  -- "mhinz/vim-startify",  -- Start screen
  "airblade/vim-rooter", -- Make project directory as root
  "wellle/targets.vim",  -- More targets
  -- Indentation
  {
    "Darazaki/indent-o-matic",
    config = function()
      require("indent-o-matic").setup({
        -- The values indicated here are the defaults

        -- Number of lines without indentation before giving up (use -1 for infinite)
        max_lines = 2048,

        -- Space indentations that should be detected
        standard_widths = { 2, 4, 8 },

        -- Skip multi-line comments and strings (more accurate detection but less performant)
        skip_multiline = true,
      })
    end
  },
  {
    "mluders/comfy-line-numbers.nvim", -- Relative numbers on normal, Normal numbers on insert
    config = function()
      require("comfy-line-numbers").setup()
    end
  },
  ---- Lisp parinfer
  {
    "eraserhd/parinfer-rust",
    ft = { "clojure", "scheme", "racket", "common lisp", "dune" },
    build = "cargo build --release",
  },
  --"guns/vim-sexp",                              -- Lisp motions
  -- "tpope/vim-sexp-mappings-for-regular-people", -- Lisp-sexp mappings
  "tpope/vim-surround",  -- Surround parens
  -- "tpope/vim-endwise",             -- highlight matching blocks
  "rstacruz/vim-closer", -- Auto close parens
  -- "tpope/vim-unimpaired",          -- Bracket mappings
  "tpope/vim-fugitive",  -- Git
  "tpope/vim-repeat",    -- Repeat last command
  -- "tpope/vim-eunuch",              -- Unix commands
  -- "andymass/vim-matchup",          -- Match blocks
  "machakann/vim-highlightedyank", -- Highlight yank
  "chaoren/vim-wordmotion",        -- Word motions work with camelcase
  {
    "echasnovski/mini.pick",       -- Picker
    lazy = false,
  },
  --"/usr/local/opt/ripgrep",       -- Better than ag
  "kblin/vim-fountain",    -- Fountain syntax
  "towolf/vim-helm",       -- Helm templates
  "neovim/nvim-lspconfig", -- Language server protocol configurations.
  {
    "saghen/blink.cmp",
    lazy = false,
    build = function()
      require('blink.cmp').build():wait(60000)
    end,
    --@module "blink.cmp"
    --@type blink.cmp.Config
    opts = {
      keymap = { preset = "enter" },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
      },
      sources = {
        default = {
          "lsp",
          "buffer",
        },
      },
    },
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",

    },
  },
  -- Scrollbar with diagnostics
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  },
  "APZelos/blamer.nvim", -- Git blame
  -- Better, faster gitgutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
        end,
      })
    end
  },
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
      require("tree-sitter-manager").setup({
        -- Default Options
        -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session. If set to "all", install all parsers.
        -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
        -- auto_install = false, -- if enabled, install missing parsers when editing a new file
        -- highlight = true, -- treesitter highlighting is enabled by default
        -- languages = {}, -- override or add new parser sources
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "rust",
          "go",
        }
      })
    end
  },
  --{
  -- Code highlight
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   branch = "main",
  --   opts = {
  --     ensure_installed = {
  --       "lua",
  --       "python",
  --       "javascript",
  --       "javascriptreact",
  --       "typescript",
  --       "typescriptreact",
  --       "markdown",
  --     },
  --     prefer_git = true,
  --     compilers = { "gcc-14" },
  --   }
  -- },
  -- "nvim-treesitter/nvim-treesitter-textobjects", -- Textobjects
  --"hiphish/rainbow-delimiters.nvim", -- Rainbow parens
  -- Context (disabled until upstream nil-node crash on markdown is fixed)
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup({
  --       enable = true,
  --       max_lines = 1,
  --     })
  --   end
  -- },
  { -- Lsp search displays in FZF
    "ojroques/nvim-lspfuzzy",
    branch = "main",
  },
  -- Statusline
  {
    "echasnovski/mini.statusline",
    config = function()
      require("mini.statusline").setup({
        content = {
          active = nil,
          inactive = nil,
        },
        use_icons = false,
        set_vim_settings = true,
      })
    end
  },
  -- Tree viewer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        },
        git = {
          ignore = false,
        },
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
            },
          },
          highlight_git = true,
          highlight_opened_files = "name",
          indent_markers = {
            enable = true,
          },
        },
        filters = {
          dotfiles = true,
        },
        ui = {
          confirm = {
            remove = false,
            trash = false,
            default_yes = true
          }
        }
      })
    end
  },
  -- Color preview
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup()
  --   end
  -- },
  -- Linting
  "b0o/schemastore.nvim", -- JSON schema store
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "biomejs" },
        json = { "biomejs", "jsonlint" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
        javascriptreact = { "biomejs" },
        vim = { "stylelint" },
        sh = { "shellcheck" },
        clojure = { "clj-kondo" },
        lua = { "luacheck" },
        go = { "golangcilint" },
        python = { "ruff" },
        dockerfile = { "hadolint" },
        terraform = { "tflint" },
        ghaction = { "actionlint" },
      }
      lint.linters.luacheck = {
        name = "luacheck",
        cmd = "luacheck",
        args = { "--globals", "vim", "lvim", "reload", "--", },
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
          source = "luacheck",
        }),
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        pattern = {
          "*.py",
          "*.js",
          "*.cjs",
          "*.ts",
          "*.tsx",
          "*.vim",
          "*.sh",
          "*.clj",
          "*.lua",
          "*.go",
        },
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
  --"mhartington/formatter.nvim",               -- Formatter
  -- Formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports", lsp_format = "fallback" },
          javascript = { "biome", "biome-organize-imports" },
          typescript = { "biome", "biome-organize-imports" },
          go = { "gofumpt" },
          html = { "superhtml" },
        },
      })
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      vim.keymap.set("n", "<leader>f=", require("conform").format, { silent = true })
    end
  },
  -- Highlight jump targets
  {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end
  },
  -- Motions
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      local leap = require("leap")
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', { silent = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { silent = true })
      vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)', { silent = true })
      vim.keymap.set({ 'x', 'o' }, 'x', '<Plug>(leap-forward-till)', { silent = true })
      vim.keymap.set({ 'x', 'o' }, 'X', '<Plug>(leap-backward-till)', { silent = true })
      leap.opts.case_sensitive = false
      leap.opts.max_highlighted_matches = 256
    end
  },
  -- Hop around AST
  {
    "ggandor/leap-ast.nvim",
    dependencies = { "https://codeberg.org/andyg/leap.nvim" },
  },
  -- Themes
  -- Gruvbox colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      local gruvbox = require("gruvbox")
      local palette = gruvbox.palette
      -- local is_dark = vim.opt.background:get() == "dark"
      gruvbox.setup({
        contrast = "soft", -- is_dark and "hard" or "soft",
        dim_inactive = true,
        overrides = {
          QuickScopePrimary = { fg = palette.neutral_orange, bold = true },
          QuickScopeSecondary = { fg = palette.neutral_green, bold = true },
          TreesitterContextBottom = { bg = palette.light2 },
          TreesitterContextLineNumberBottom = { bg = palette.light2 },
        }
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  "powerman/vim-plugin-AnsiEsc", -- Ansi escape sequences
  -- Peek lines
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  {
    "clojure-vim/vim-jack-in", -- Jack in to clojure
    dependencies = { "radenling/vim-dispatch-neovim" }
  },
  {
    "Olical/conjure",
    ft = { "clojure" },
    branch = "main",
  },
})
