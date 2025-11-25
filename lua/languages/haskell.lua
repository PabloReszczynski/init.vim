-- Haskell LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("hls", {
    on_attach = common.on_attach,
    capabilities = common.default_capabilities,
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
    configured = true
  end
  vim.lsp.enable("hls")
end

return M

