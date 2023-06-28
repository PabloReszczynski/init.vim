-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Project.nvim
require("project_nvim").setup({})

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

local telescope = require("telescope")
telescope.load_extension("fzf")
telescope.load_extension("notify")
telescope.load_extension("projects")
telescope.load_extension("ui-select")

-- Noice
-- require("noice").setup({

-- })

-- NV
-- require("neuron").setup({
--   virtual_titles = true,
--   mappings = true,
--   run = nil, -- function to run when in neuron dir
--   neuron_dir = "~/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
--   leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
-- })

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

local on_attach = function(_, bufnr)
  local function buf_keymap(mode, keymap, callback)
    vim.keymap.set(mode, keymap, callback, { buffer = bufnr, noremap = true })
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  buf_keymap("n", "gD", vim.lsp.buf.declaration)
  buf_keymap("n", "gd", vim.lsp.buf.definition)
  buf_keymap("n", "K", vim.lsp.buf.hover)
  buf_keymap("n", "C-k", vim.lsp.buf.signature_help)
  buf_keymap("i", "C-k", vim.lsp.buf.signature_help)
  buf_keymap("n", "gi", require("telescope.builtin").lsp_implementations)
  buf_keymap("n", "gr", vim.lsp.buf.references)
  buf_keymap("n", "<leader> rn", vim.lsp.buf.rename)
  buf_keymap("n", "<C-a>", vim.lsp.buf.code_action)
  buf_keymap("n", "<leader>=", function()
    vim.lsp.buf.format({ timeout_ms = 5000 })
  end)
  buf_keymap("n", "J", show_line_diagnostics)
  buf_keymap("n", "[d", vim.diagnostic.goto_prev)
  buf_keymap("n", "]d", vim.diagnostic.goto_next)

  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.inlay_hint(bufnr, true)
    end,
  })
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.inlay_hint(bufnr, false)
    end,
  })

  -- Set tab config again because a plugin is resetting it for some reason
  vim.bo[bufnr].tabstop = 2
  vim.bo[bufnr].softtabstop = 2
  vim.bo[bufnr].shiftwidth = 2
  vim.bo[bufnr].expandtab = true
  vim.bo[bufnr].autoindent = true
  vim.bo[bufnr].smartindent = true
  vim.o.smarttab = true
end

-- vim.keymap.set({'n', 'x', 'o'}, 'x', function() require'leap-ast'.leap() end, {})

-- NULL-LS diagnostics
local nls = require("null-ls")

nls.setup({
  on_attach = on_attach,
  debug = true,
  sources = {
    -- Lua
    nls.builtins.formatting.stylua,

    -- Python
    nls.builtins.formatting.isort,
    nls.builtins.formatting.black,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.mypy,

    -- Javascript
    nls.builtins.diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    nls.builtins.formatting.eslint.with({
      prefer_local = "node_modules/.bin",
    }),

    -- Vim
    nls.builtins.diagnostics.stylelint,
    nls.builtins.formatting.stylelint,

    -- Shell
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.formatting.shellharden,

    -- Clojure
    nls.builtins.formatting.cljstyle.with({}),

    -- Swift
    nls.builtins.formatting.swiftformat,

    -- Racket
    nls.builtins.formatting.racket_fixw,
  },
})

-- LSP Configuration

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local nvim_lsp = require("lspconfig")
local lsp_servers = {
  "tsserver",
  "rust_analyzer",
  "pyright",
  --"jedi_language_server",
  "dartls",
  "hls",
  "jsonls",
  "ocamllsp",
  "gopls",
  "clangd",
  "texlab",
  "clojure_lsp",
  "sourcekit",
  "sourcekit",
  "ltex",
  "lua_ls",
  "tailwindcss",
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  width = 80,
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
      close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
    })

-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
--   border = 'single'
-- })

for _, server in ipairs(lsp_servers) do
  if server == "tsserver" then
    nvim_lsp[server].setup({
      on_attach = function(client, bufr)
        client.server_capabilities["document_formatting"] = false
        on_attach(client, bufr)
      end,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })
  elseif server == "rust_analyzer" then
    nvim_lsp[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            allFeatures = true,
            overrideCommand = {
              "cargo",
              "clippy",
              "--workspace",
              "--message-format=json",
              "--all-targets",
              "--all-features",
            },
          },
        },
      },
    })
  elseif server == "lua_ls" then
    nvim_lsp[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  elseif server == "gopls" then
    nvim_lsp[server].setup({
      on_attach = on_attach,
      filetypes = { "go", "gomod" },
      cmd = {
        "gopls",
        "--remote.debug=:0",
      },
      flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          experimentalPostfixCompletions = true,
          codelenses = {
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
            generate = true,
            gc_details = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          matcher = "fuzzy",
          diagnosticsDelay = "500ms",
          symbolMatcher = "fuzzy",
          semanticTokens = true,
        },
      },
    })
  else
    nvim_lsp[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
    { name = "conjure" },
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
  ignore_install = { "haskell", "lua", "latex" },
  highlight = {
    enable = true,
    disable = { "latex" },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
    colors = {
      "#cc241d",
      "#98971a",
      "#d79921",
      "#458588",
      "#b16286",
      "#689d6a",
      "#d65d0e",
    },
    termcolors = {
      "Red",
      "Green",
      "Yellow",
      "Blue",
      "Magenta",
      "Cyan",
      "White",
    },
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

-- LSP Colors
local lspColors = require("lsp-colors")

lspColors.setup({
  Error = "#fb4934",
  Warning = "#fabd2f",
  Information = "#83a598",
  Hint = "#8ec07c",
})

-- Leap
require("leap").set_default_keymaps()

-- Vista
vim.g.vista_default_executive = "nvim_lsp"
vim.g["vista#renderer#enable_icon"] = 1
vim.g.vista_sidebar_width = 20
vim.keymap.set(
  "n",
  "<leader>vv",
  ":Vista!!<CR>",
  { silent = true, remap = true }
)
vim.keymap.set(
  "n",
  "<leader>tt",
  ":Vista finder<CR>",
  { silent = true, remap = true }
)

-- DAP
local dap = require("dap")
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
  },
}

require("dapui").setup({})

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

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
    }),
    require("neotest-plenary"),
  },
})

require('numb').setup()
