local treesitter_config = require"nvim-treesitter.configs"
local treesitter_install = require"nvim-treesitter.install"
require('gitsigns').setup()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<leader> gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader> rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<c-a>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.format({}, 5000)<CR>', opts)
  buf_set_keymap('n', 'J', '<cmd>lua show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- NULL-LS diagnostics
local nls = require("null-ls")

nls.setup({
    on_attach = on_attach,
    debug = true,
    sources = {
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.black,
      nls.builtins.diagnostics.eslint.with({
        prefer_local = "node_modules/.bin"
      }),
      nls.builtins.formatting.prettier.with({
        prefer_local = "node_modules/.bin",
      }),
      nls.builtins.diagnostics.vint,
    },
})

-- LSP Configuration

local nvim_lsp = require"lspconfig"
local lsp_servers = {
  "tsserver",
  "rls",
  "pylsp",
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
}
local nvim = vim

-- Line diagnostics
function show_line_diagnostics()
  nvim.diagnostic.open_float({
      focusable = false,
      width = 80
    })
end


vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  width = 80,
  border = 'single'
})

-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
--   border = 'single'
-- })

for _, server in ipairs(lsp_servers) do
  if server == "tsserver" then
    nvim_lsp[server].setup {
      on_attach = function (client, bufr)
        client.server_capabilities["document_formatting"] = false
        on_attach(client, bufr)
      end
    }
  elseif server == "rescriptls" then
    nvim_lsp[server].setup {
      on_attach = on_attach,
      cmd = {
        "node",
        "/Users/p/repos/rescript-vscode/server/out/server.js",
        "--stdio"
      }
    }
  else
    nvim_lsp[server].setup {
      on_attach = on_attach
    }
  end
end

-- Dressing
require'dressing'.setup {
  enabled = true,
  select = {
    enabled = true,
    fzf = {
      window = {
        width = 0.5,
        height = 0.4
      }
    }
  }
}

nvim.g.tmuxline_separators = {
  left = "",
  left_alt = "|",
  right = "",
  right_alt = "|",
  space = " "
}

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
    pandoc = true;
  }
}

treesitter_config.setup({
    ensure_installed = "all",
    ignore_install = { "haskell", "lua", "latex" },
    highlight = { enable = true },
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
         "#d65d0e"
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

treesitter_install.prefer_git = true

require"lspfuzzy".setup {}

local time = vim.fn['strftime']"%H"

local theme = function (time)
  if time < 18 then
    return "gruvbox_light"
  else
    return "gruvbox"
  end
end


-- GPS
local gps = require("nvim-gps")
gps.setup()

-- Lunaline
require("lualine").setup {
  options = {
    theme = "gruvbox",
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    icons_enabled = false
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {
      {
        gps.get_location, cond = gps.is_available
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {
    "nvim-tree",
    "fzf",
    "fugitive",
  }
}

-- Nvim tree
require"nvim-tree".setup {
  diagnostics = {
    enable = true
  },
  git = {
    ignore = false
  }
}

nvim.api.nvim_command('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')

-- Colorizer
require"colorizer".setup()

-- Scrollbar
require("scrollbar").setup()

-- Lightbulb

require('nvim-lightbulb').setup({
  autocmd = {enabled = true},
  ignore = { "null-ls" },
  sign = {
    enabled = true,
    text = "🂱",
  }
})

vim.opt.winbar = "%#WinBarSeparator# %*%#WinBarContent#%f%*%#WinBarSeparator# %*"
