-- JSON/JSONC LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("yamlls", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        }
      }
    })

    configured = true
  end
  vim.lsp.enable("yamlls")
end

return M

