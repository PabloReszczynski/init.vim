-- OCaml LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("ocamllsp", {
    on_attach = common.on_attach,
    capabilities = common.default_capabilities,
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
    configured = true
  end
  vim.lsp.enable("ocamllsp")
end

return M

