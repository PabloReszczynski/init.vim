-- Rust LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("rust_analyzer", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            experimental = true,
          },
          checkOnSave = {
            allFeatures = true,
            overrideCommand = {
              "cargo",
              "+nightly",
              "clippy",
              "--workspace",
              "--message-format=json",
              "--all-targets",
              "--all-features",
            },
          }
        }
      }
    })
    configured = true
  end
  vim.lsp.enable("rust_analyzer")
end

return M

