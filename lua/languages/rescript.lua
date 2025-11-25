-- ReScript LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("rescriptls", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
    })
    configured = true
  end
  vim.lsp.enable("rescriptls")
end

return M

