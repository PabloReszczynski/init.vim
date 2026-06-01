-- Python LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

-- Using Zuban as the primary Python LSP
function M.setup()
  if not configured then
    vim.lsp.config("zubanls", {
      name = "ZubanLS",
      cmd = { "zuban", "server" },
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
    })
    configured = true
  end
  vim.lsp.enable("zubanls")
end

return M
