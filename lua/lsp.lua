-- Global LSP configuration and handlers
-- Individual language servers are configured in ftplugin files

local M = {}

function M.setup()
  -- Global LSP configuration
  vim.lsp.config("*", {
    root_markers = { ".git" }
  })

  -- Configure LSP handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
    width = 80,
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.buf.signature_help({
        border = "single",
        close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
      })
end

return M
