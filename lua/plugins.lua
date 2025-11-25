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
  -- UI improvements
  -- {
  --   "stevearc/dressing.nvim",
  --   config = function()
  --     require("dressing").setup({
  --       input = {
  --         enabled = true,
  --         border = "single",
  --       },
  --       select = {
  --         telescope = require("telescope.themes").get_ivy(),
  --         builtin = {
  --           border = "single"
  --         }
  --       },
  --     })
  --   end
  -- },
  -- "lewis6991/impatient.nvim", -- Speed up startup
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
  -- "neoclide/jsonc.vim",            -- Allow comments in JSON
  "machakann/vim-highlightedyank", -- Highlight yank
  "chaoren/vim-wordmotion",        -- Word motions work with camelcase
  {
    "echasnovski/mini.pick",       -- Picker
    lazy = false,
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function()
  --     local telescope = require("telescope")
  --     telescope.setup({
  --       fzf = {
  --         fuzzy = true,
  --         override_generic_sorter = true, -- override the generic sorter
  --         override_file_sorter = true,    -- override the file sorter
  --         case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
  --       },
  --       defaults = {
  --         mappings = {
  --           i = {
  --             ["<C-j>"] = require("telescope.actions").move_selection_next,
  --             ["<C-k>"] = require("telescope.actions").move_selection_previous,
  --           },
  --         },
  --         layout_strategy = "horizontal",
  --       },
  --       extensions = {
  --         ["ui-select"] = {
  --           layout_strategy = require("telescope.themes").get_ivy().layout_config.strategy,
  --           layout_config = {
  --             width = 0.4,
  --             height = 0.3,
  --           },
  --         },
  --       },
  --       pickers = {
  --         buffers = {
  --           theme = "ivy",
  --         },
  --         find_files = {
  --           theme = "ivy",
  --         },
  --         live_grep = {
  --           theme = "ivy",
  --         },
  --         spell_suggest = {
  --           theme = "ivy",
  --         },
  --       },
  --     })
  --     telescope.load_extension("ui-select")
  --   end
  -- },                                         -- Fuzzy finding
  -- "nvim-telescope/telescope-ui-select.nvim", -- Use telescope for actions
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   build =
  --   "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  -- },
  --"/usr/local/opt/ripgrep",       -- Better than ag
  -- "vim-pandoc/vim-pandoc",        -- Markdown
  -- "vim-pandoc/vim-pandoc-syntax", -- Markdown syntax
  {
    "MeanderingProgrammer/render-markdown.nvim", -- Markdown syntax
    config = function()
      require("render-markdown").setup({
        completions = {
          blink = {
            enabled = true,
          }
        }
      })
    end
  },
  "kblin/vim-fountain", -- Fountain syntax
  -- {
  --   "folke/zen-mode.nvim", -- Distraction free writing
  --   opts = {
  --     window = {
  --       options = {
  --         number = false,
  --       }
  --     },
  --     on_open = function()
  --       vim.cmd("Gitsigns detach_all")
  --     end,
  --     on_close = function()
  --       vim.cmd("Gitsigns attach")
  --     end,
  --   }
  -- },
  -- "folke/twilight.nvim",   -- Dim inactive portions of text
  "towolf/vim-helm",       -- Helm templates
  -- "chrisbra/unicode.vim",  -- Unicode search
  "neovim/nvim-lspconfig", -- Language server protocol configurations.
  {
    "saghen/blink.cmp",
    lazy = false,
    build = "cargo build --release",
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
          "copilot",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          }
        }
      }
    },
    dependencies = { "fang2hou/blink-copilot" }
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
    -- Code highlight
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-textobjects", -- Textobjects
  --"hiphish/rainbow-delimiters.nvim", -- Rainbow parens
  -- Context
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 1,
      })
    end
  },
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
          html = { "superhtml", "fmt" },
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
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', { silent = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { silent = true })
      vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)', { silent = true })
      vim.keymap.set({'x', 'o'}, 'x', '<Plug>(leap-forward-till)', { silent = true })
      vim.keymap.set({'x', 'o'}, 'X', '<Plug>(leap-backward-till)', { silent = true })
      leap.opts.case_sensitive = false
      leap.opts.max_highlighted_matches = 256
    end
  },
  -- Hop around AST
  {
    "ggandor/leap-ast.nvim",
    dependencies = { "ggandor/leap.nvim" },
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
  -- "sainnhe/everforest", -- Everforest colorscheme
  --  Catppuccin colorscheme
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   disable = true,
  --   config = function()
  --     require("catppuccin").setup({
  --       background = {
  --         light = "latte",
  --         dark = "frappe",
  --       },
  --       custom_highlights = function(colors)
  --         return {
  --           QuickScopePrimary = { fg = colors.rosewater, underline = true },
  --           QuickScopeSecondary = { fg = colors.green, underline = true },
  --           TreesitterContextBottom = { bg = colors.lavender, fg = colors.base, underline = true },
  --           TreesitterContextLineNumberBottom = { bg = colors.lavender, underline = true },
  --         }
  --       end,
  --       integrations = {
  --         blink_cmp = true,
  --         leap = true,
  --       },
  --     })
  --     -- vim.cmd([[colorscheme catppuccin]])
  --   end
  -- },
  {
    "L3MON4D3/LuaSnip", -- Snippets engine
    version = "2.*",
    build = "make install_jsregexp",
  },
  -- Github PRs
  -- {
  --   "pwntester/octo.nvim",
  --   config = function()
  --     require("octo").setup()
  --   end
  -- },
  --"github/copilot.vim",          -- Github Copilot
  {
    -- Copilot Replacement in Lua
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        workspace_folders = {
          "/Users/p/repos",
          "/Users/p/topsort",
        },
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
        },
      })
    end
  },
  "powerman/vim-plugin-AnsiEsc", -- Ansi escape sequences
  -- Peek lines
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  --"rescript-lang/vim-rescript",               -- Rescript
  --"edwinb/idris2-vim",                        -- Idris 2
  {
    "clojure-vim/vim-jack-in", -- Jack in to clojure
    dependencies = { "tpope/vim-dispatch" }
  },
  {
    "Olical/conjure",
    ft = { "clojure" },
    branch = "main",
  },
})
