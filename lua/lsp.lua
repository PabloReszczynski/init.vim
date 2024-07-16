-- LSP Configurations
--
local lsp_servers = {
  "kotlin_language_server",
  "tsserver",
  "rust_analyzer",
  --"pyright",
  --"jedi_language_server",
  "pylsp",
  "hls",
  "ocamllsp",
  "gopls",
  "clangd",
  "clojure_lsp",
  "sourcekit",
  "lua_ls",
  "ocamllsp",
  "biome",
  "zls",
  "elixirls",
  "rescriptls",
  "sourcekit",
}


local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Line diagnostics
local show_line_diagnostics = function()
  vim.diagnostic.open_float({
    focusable = false,
    width = 80,
  })
end

-- Global on_attach function
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
  buf_keymap("n", "<leader>r", vim.lsp.buf.rename)
  buf_keymap("n", "<C-a>", vim.lsp.buf.code_action)
  buf_keymap("n", "<leader>=", function()
    vim.lsp.buf.format({ timeout_ms = 5000 })
  end)
  buf_keymap("n", "J", show_line_diagnostics)
  buf_keymap("n", "[d", vim.diagnostic.goto_prev)
  buf_keymap("n", "]d", vim.diagnostic.goto_next)

  -- Set tab config again because a plugin is resetting it for some reason
  vim.bo[bufnr].tabstop = 2
  vim.bo[bufnr].softtabstop = 2
  vim.bo[bufnr].shiftwidth = 2
  vim.bo[bufnr].expandtab = true
  vim.bo[bufnr].autoindent = true
  vim.bo[bufnr].smartindent = true
  vim.o.smarttab = true
  vim.g.expandtab = true
end

local enable_inlay_hints = function(bufnr)
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
end

local function tsserver(setup)
  setup({
    on_attach = function(client, bufnr)
      client.server_capabilities["document_formatting"] = false
      on_attach(client, bufnr)
    end,
    capabilities = default_capabilities,
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
    }
  })
end

local function rust_analyzer(setup)
  setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
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
        }
      }
    }
  })
end

local function lua_ls(setup)
  setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
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
end

local function gopls(setup)
  setup({
    on_attach = on_attach,
    capabilities = {
      textDocument = {
        codeAction = {
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = {
                "",
                "Empty",
                "quickfix",
                "refactor",
                "refactor.extract",
                "refactor.inline",
                "refactor.rewrite",
                "source",
                "source.organizeImports",
              }
            }
          }
        },
        definition = {
          linkSupport = true,
        },
        hover = {
          contentFormat = {
            "markdown",
            "plaintext",
          },
        },
      }
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
        gofumpt = true,
      },
    },
  })
end

local function hls(setup)
  setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
    filetypes = { "haskell", "lhaskell", "cabal" },
    settings = {
      haskell = {
        formattingProvider = "stylish-haskell",
        plugin = {
          rename = {
            config = {
              diff = true,
            }
          }
        }
      }
    }
  })
end

local function pylsp(setup)
  setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
    settings = {
      pylsp = {
        configurationSources = { "flake8" },
        plugins = {
          autopep8 = {
            enabled = false,
          },
          flake8 = {
            enabled = true,
          },
          pydocstyle = {
            enabled = true,
          },
        }
      }
    }
  })
end

local function ocamllsp(setup)
  setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
    settings = {
      ocamllsp = {
        format = {
          width = 80,
          margin = 2,
        },
        fallback_read_dot_merlin = true,
      },
    },
  })
end

local function elixirls(setup)
  setup({
    on_attach = on_attach,
    capabilities = default_capabilities,
    cmd = { "/usr/local/Cellar/elixir-ls/0.20.0/bin/elixir-ls" },
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = false,
        mixEnv = "dev",
      },
    }
  })
end

local lsp_configurations = {
  tsserver = tsserver,
  rust_analyzer = rust_analyzer,
  lua_ls = lua_ls,
  gopls = gopls,
  hls = hls,
  pylsp = pylsp,
  elixirls = elixirls,
}

local function setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        float = {
          format = function(diag)
            return string.format(
              "%s (%s) (%s)",
              diag.message,
              diag.source,
              diag.code or diag.user_data.lsp.code
            )
          end
        },
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

  local lspconfig = require("lspconfig")
  for _, server in ipairs(lsp_servers) do
    local _setup = lspconfig[server].setup
    if not _setup then
      print("LSP server " .. server .. " not found")
    elseif lsp_configurations[server] then
      lsp_configurations[server](_setup)
    else
      _setup({
        on_attach = on_attach,
        capabilities = default_capabilities,
      })
    end
  end
end

local lsp = {
  setup = setup,
}

return lsp
