-- Lua LSP configuration
local common = require("lsp.common")

local M = {}

local configured = false

function M.setup()
  if not configured then
    vim.lsp.config("lua_ls", {
      on_attach = common.on_attach,
      capabilities = common.default_capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
    configured = true
  end
  vim.lsp.enable("lua_ls")
end

return M

