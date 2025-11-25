-- TypeScript/JavaScript LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    -- ts_ls for type checking and IntelliSense
    vim.lsp.config("ts_ls", {
      on_attach = function(client, bufnr)
        client.server_capabilities["document_formatting"] = false
        common.on_attach(client, bufnr)
        vim.print("ts_ls attached")
      end,
      capabilities = common.default_capabilities,
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
          lens = {
            enable = true,
          }
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
          lens = {
            enable = true,
          }
        },
      },
    })

    -- Biome for linting and formatting
    vim.lsp.config("biome", {
      -- on_attach = common.on_attach,
      capabilities = common.default_capabilities,
    })

    configured = true
  end

  vim.lsp.enable("ts_ls")
  vim.lsp.enable("biome")
  vim.print("TypeScript/JavaScript LSPs enabled")
end

return M
