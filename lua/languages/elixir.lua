-- Elixir LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("elixirls", {
    on_attach = common.on_attach,
    capabilities = common.default_capabilities,
    cmd = { "/usr/local/Cellar/elixir-ls/0.20.0/bin/elixir-ls" },
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = false,
        mixEnv = "dev",
      },
    }
  })
    configured = true
  end
  vim.lsp.enable("elixirls")
end

return M

