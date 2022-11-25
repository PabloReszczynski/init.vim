local treesitter_config = require("nvim-treesitter.configs")
local treesitter_install = require("nvim-treesitter.install")
require("gitsigns").setup()

-- Line diagnostics
local show_line_diagnostics = function()
  vim.diagnostic.open_float({
    focusable = false,
    width = 80,
  })
end

local on_attach = function(_, bufnr)
  local function buf_keymap(mode, keys, callback)
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, "", {
      noremap = true,
      silent = true,
      callback = callback,
    })
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  buf_keymap("n", "<leader> gd", vim.lsp.buf.declaration)
  buf_keymap("n", "gd", vim.lsp.buf.definition)
  buf_keymap("n", "K", vim.lsp.buf.hover)
  buf_keymap("n", "gD", vim.lsp.buf.implementation)
  buf_keymap("n", "<leader> rn", vim.lsp.buf.rename)
  buf_keymap("n", "<c-a>", vim.lsp.buf.code_action)
  buf_keymap("n", "<leader>=", function()
    vim.lsp.buf.format({}, 5000)
  end)
  buf_keymap("n", "J", show_line_diagnostics)
  buf_keymap("n", "[d", vim.diagnostic.goto_prev)
  buf_keymap("n", "]d", vim.diagnostic.goto_next)
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
    nls.builtins.formatting.prettier.with({
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
  "rescriptls",
  "sourcekit",
  "ltex",
  "sumneko_lua",
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
    })
  elseif server == "rescriptls" then
    nvim_lsp[server].setup({
      on_attach = on_attach,
      cmd = {
        "node",
        "/Users/p/repos/rescript-vscode/server/out/server.js",
        "--stdio",
      },
    })
  elseif server == "rust_analyzer" then
    nvim_lsp[server].setup({
      on_attach = on_attach,
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
  elseif server == "sumneko_lua" then
    nvim_lsp[server].setup({
      settings = {
        Lua = {
          version = "LuaJIT",
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
  else
    nvim_lsp[server].setup({
      on_attach = on_attach,
    })
  end
end

-- Dressing
require("dressing").setup({
  enabled = true,
  select = {
    enabled = true,
    fzf = {
      window = {
        width = 0.5,
        height = 0.4,
      },
    },
  },
})

require("fzf_lsp").setup()

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
  }),

  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
})

treesitter_config.setup({
  ignore_install = { "haskell", "lua", "latex" },
  highlight = {
    enable = true,
    disable = { "haskell", "lua", "latex" },
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
})

treesitter_install.prefer_git = true

require("lspfuzzy").setup({})

local time = vim.fn["strftime"]("%H")

local theme = function(time)
  if time < 18 then
    return "gruvbox_light"
  else
    return "gruvbox"
  end
end

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
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "⧱",
      info = "⧯",
      warning = "⚠",
      error = "⚠",
    },
  },
  git = {
    ignore = false,
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = false,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = " ",
        git = {
          unstaged = "☐",
          staged = "☑",
          unmerged = "",
          deleted = "☒",
        },
        folder = {
          arrow_closed = "•",
          arrow_open = "‣",
        },
      },
      webdev_colors = true,
    },
    highlight_git = true,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
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
