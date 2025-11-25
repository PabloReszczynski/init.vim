-- Go LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("gopls", {
    on_attach = common.on_attach,
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
    configured = true
  end
  vim.lsp.enable("gopls")
end

return M

