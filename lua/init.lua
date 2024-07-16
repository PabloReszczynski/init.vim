-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("impatient") -- Setup a cache for faster startup

-- Project.nvim
-- require("project_nvim").setup({})

-- Telescope
require("telescope").setup({
  fzf = {
    fuzzy = true,
    override_generic_sorter = true, -- override the generic sorter
    override_file_sorter = true,    -- override the file sorter
    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
  },
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
    layout_strategy = "horizontal",
  },
  extensions = {
    ["ui-select"] = {
      layout_strategy = "cursor",
      layout_config = {
        width = 0.4,
        height = 0.3,
      },
    },
  },
})


local gruvbox_config = {
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  striketrough = true,
  invert_selection = false,
  invert_signs = false,
  contrast = "soft",
  palette_overrides = {
    bright_orange = "#f56e0f",
  }
}
require("gruvbox").setup(gruvbox_config)
vim.cmd([[colorscheme gruvbox]])

vim.api.nvim_create_autocmd({ "ColorScheme", "ColorSchemePre" }, {
  pattern = { "*" },
  callback = function()
    local bg = vim.o.background
    if bg == "light" then
      vim.g.lualine_theme = "gruvbox_light"
      require("gruvbox").setup({
        gruvbox_config,
        contrast = "soft",
      })
    else
      vim.g.lualine_theme = "gruvbox"
      require("gruvbox").setup({
        gruvbox_config,
        contrast = "hard",
      })
    end
  end
})


local telescope = require("telescope")
--telescope.load_extension("fzf")
-- telescope.load_extension("notify")
-- telescope.load_extension("projects")
telescope.load_extension("ui-select")


-- Treesitter
local treesitter_config = require("nvim-treesitter.configs")
local treesitter_install = require("nvim-treesitter.install")

-- Gitsignes
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

-- Line diagnostics
local show_line_diagnostics = function()
  vim.diagnostic.open_float({
    focusable = false,
    width = 80,
  })
end

-- Linting
local lint = require("lint")
lint.linters_by_ft = {
  javascript = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  javascriptreact = { "eslint" },
  vim = { "stylelint" },
  sh = { "shellcheck" },
  clojure = { "clj-kondo" },
  lua = { "luacheck" },
  go = { "golangcilint" },
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

-- Formatting
local format_settings = {
  python = {
    require("formatter.filetypes.python").black,
    require("formatter.filetypes.python").isort,
  },
  javascript = {
    require("formatter.filetypes.javascript").prettier,
  },
  typescript = {
    require("formatter.filetypes.typescript").prettier,
  },
  typescriptreact = {
    require("formatter.filetypes.typescriptreact").prettier,
  },
  javascriptreact = {
    require("formatter.filetypes.javascriptreact").prettier,
  },
  vim = {
    function()
      return {
        exe = "stylelint",
        args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
        stdin = true,
      }
    end,
  },
  sh = {
    require("formatter.filetypes.sh").shfmt,
  },
  clojure = {
    function()
      return {
        exe = "cljstyle",
        args = { "--indent", "2", "--replace" },
        stdin = true,
      }
    end,
  },
  lua = {
    require("formatter.filetypes.lua").stylua,
  },
  fish = {
    require("formatter.filetypes.fish").fishindent,
  },
  go = {
    require("formatter.filetypes.go").gofumpt,
  },
}

require("formatter").setup({
  logging = false,
  filetype = format_settings,
})

-- LSP Configuration

require("lsp").setup()

local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0

        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

treesitter_config.setup({
  incremental_selection = { enable = true },
  ignore_install = { "latex" },
  highlight = {
    enable = true,
    disable = { "latex" },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  indent = {
    enable = true,
  },
})

treesitter_install.prefer_git = true
treesitter_install.compilers = { "gcc-14" }

-- vim.g.rainbow_delimiters = {
--   highlight = {
--     "#cc241d",
--     "#98971a",
--     "#d79921",
--     "#458588",
--     "#b16286",
--     "#689d6a",
--     "#d65d0e",
--   },
-- }

-- Lunaline
require("lualine").setup({
  options = {
    theme = "gruvbox",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    icons_enabled = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    "nvim-tree",
    "fzf",
    "fugitive",
  },
})

-- Nvim tree
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
})

-- nvim.api.nvim_command('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')

-- Colorizer
require("colorizer").setup()

-- Scrollbar
require("scrollbar").setup()

vim.opt.winbar =
"%#WinBarSeparator# %*%#WinBarContent#%f%*%#WinBarSeparator# %*"

-- Leap
require("leap").set_default_keymaps()

-- VimWiki

vim.g.vimwiki_list = {
  {
    path = "~/vimwiki/",
    syntax = "markdown",
    ext = ".md",
  },
  {
    path = "~/book/wiki",
    syntax = "markdown",
    ext = ".md",
  },
}

require("indent-o-matic").setup({
  -- The values indicated here are the defaults

  -- Number of lines without indentation before giving up (use -1 for infinite)
  max_lines = 2048,

  -- Space indentations that should be detected
  standard_widths = { 2, 4, 8 },

  -- Skip multi-line comments and strings (more accurate detection but less performant)
  skip_multiline = true,
})

-- require("neotest").setup({
--   adapters = {
--     require("neotest-python")({
--       dap = { justMyCode = false },
--       runner = "pytest",
--     }),
--     require("neotest-plenary"),
--   },
-- })

require("numb").setup()

require("marks").setup()

-- Neovide configuration
if vim.g.neovide then
  vim.g.background = "light"
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_refresh_rate = 60
  vim.o.guifont = "PragmataPro Mono Liga:h16:#e-subpixelantialias"
  vim.o.linespace = 1
  vim.g.neovide_theme = "auto"

  vim.keymap.set("n", "<D-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end)

  vim.keymap.set("n", "<D-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end)
end

require("treesitter-context").setup({
  enable = true,
  max_lines = 1,
})

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = "#ebdbb2", underline = true })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { bg = "#ebdbb2", underline = true })

-- Reply repl
vim.api.nvim_set_keymap("n", "<leader>c", ":ReplSend<CR>", {
  silent = true,
  noremap = true,
})
vim.keymap.set("v", "<leader>c", ":ReplSend<CR>", {
  silent = true,
  noremap = true,
})

-- Opam User setup
function Setup_opam()
  local opam_share_dir = vim.system({ "opam", "config", "var", "share" }):wait().stdout:gsub("[\r\n]*$", "")
  local opam_configuration = {
    ["ocp-indent"] = function()
      vim.api.nvim_exec2("set rtp^=" .. opam_share_dir .. "/ocp-indent/vim", {})
    end,
    ["ocp-index"] = function()
      vim.api.nvim_exec2("set rtp^=" .. opam_share_dir .. "/ocp-index/vim", {})
    end,
    ["merlin"] = function()
      local dir = opam_share_dir .. "/merlin/vim"
      vim.api.nvim_exec2("set rtp^=" .. dir, {})
    end
  }
  local opam_check_cmdline = {
    "opam",
    "list",
    "--installed",
    "--short",
    "--sage",
    "--color=never",
    "ocp-indent",
    "ocp-index",
    "merlin"
  }
  local opam_available_tools = vim.system(opam_check_cmdline):wait().stdout:gmatch("([^\n]+)")
  for tool in opam_available_tools do
    if opam_configuration[tool] then
      opam_configuration[tool]()
    end
  end
  vim.api.source("~/.opam/default/share/ocp-indent/vim/indent/ocaml.vim")
end

--Setup_opam()
