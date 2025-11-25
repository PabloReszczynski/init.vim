-- Python LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

-- Using basedpyright as the primary Python LSP
function M.setup()
  if not configured then
    vim.lsp.config("basedpyright", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
      settings = {
        basedpyright = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "standard",
          },
          formatting = {
            provider = "ruff",
          },
        }
      }
    })
    configured = true
  end
  vim.lsp.enable("basedpyright")
end

-- Alternative: pylsp (commented out, can be enabled if preferred)
function M.setup_pylsp()
  if not configured then
    vim.lsp.config("pylsp", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
      settings = {
        pylsp = {
          plugins = {
            ruff = {
              enabled = false,
            },
            mypy = {
              enabled = false,
              liveIssues = true,
            },
            black = {
              enabled = false,
            },
            autopep8 = {
              enabled = false,
            },
            pyflakes = {
              enabled = false,
            },
          }
        }
      }
    })
    configured = true
  end
  vim.lsp.enable("pylsp")
end

return M
