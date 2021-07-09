local treesitter_config = require"nvim-treesitter.configs"
local nvim_lsp = require"lspconfig"
local lsp_servers = {
  "tsserver",
  "rls",
  "pyls",
  "dartls",
  "hls",
  "jsonls",
  "ocamllsp",
  "gopls",
  "clangd",
  "texlab",
  "clojure_lsp"
}
local nvim = vim
require('gitsigns').setup()

for _, server in ipairs(lsp_servers) do
  nvim_lsp[server].setup {
    on_attach = on_attach
  }
end

local diagnosticls = require'diagnosticls-nvim'
local eslint = require'diagnosticls-nvim.linters.eslint'
local prettier = require'diagnosticls-nvim.formatters.prettier'
diagnosticls.init {
  on_attach = on_attach -- Your custom attach function
}
diagnosticls.setup {
  ['javascript'] = {
    linter = eslint,
    formatter = prettier
  },
  ['javascriptreact'] = {
    linter = eslint,
    formatter = prettier
  },
  ['typescript'] = {
    linter = eslint,
    formatter = prettier
  },
  ['typescriptreact'] = {
    linter = eslint,
    formatter = prettier
  }
}



nvim.g.tmuxline_separators = {
  left = "",
  left_alt = "|",
  right = "",
  right_alt = "|",
  space = " "
}

nvim.g.tmuxline_theme = "gruvbox"

nvim.g.lsp_diagnostics_enabled = 1

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout =400;

  source = {
    omni = true;
    path = false;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = false;
    vsnip = false;
    tags = false;
    treesitter = true;
  }
}

treesitter_config.setup({
    ensure_installed = "all",
    ignore_install = { "haskell" },
    highlight = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
      colors = {
         "#ff5555",
         "#50fa7b",
         "#f1fa8c",
         "#8be9fd",
         "#bd93f9",
         "#ff79c6",
         "#ffb86c"
      },
      termcolors = {
        'Red',
        'Green',
        'Yellow',
        'Blue',
        'Magenta',
        'Cyan',
        'White',
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
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
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

require"lspfuzzy".setup {}

require("lualine").setup {
  options = {
    theme = "dracula",
    section_separators = { '', '' },
    component_separators = { '', '' },
    icons_enabled = false
  }
}

-- Line diagnostics
function show_line_diagnostics()
  nvim.lsp.diagnostic.show_line_diagnostics({
      show_header = false,
      focusable = false,
      anchor = 'NW'
    })
end
nvim.api.nvim_command('autocmd CursorHold * silent! lua show_line_diagnostics()')
nvim.api.nvim_command('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')
