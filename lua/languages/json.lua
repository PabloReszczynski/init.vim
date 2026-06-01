-- JSON/JSONC LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    -- Biome handles JSON/JSONC along with JS/TS
    vim.lsp.config("biome", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
    })

    vim.lsp.config("jsonls", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        }
      }
    })

    configured = true
  end
  vim.lsp.enable("biome")
  --vim.lsp.enable("jsonls")
end

return M

