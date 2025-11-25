-- Zig LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("zls", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
    })
    configured = true
  end
  vim.lsp.enable("zls")
end

return M

