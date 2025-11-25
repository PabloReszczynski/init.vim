-- Common LSP utilities and configurations
local M = {}

-- Default capabilities from blink.cmp
M.default_capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

-- Line diagnostics
local show_line_diagnostics = function()
  vim.diagnostic.open_float({
    focusable = false,
    width = 80,
  })
end

local function get_lsp_references(bufnr)
  local params = vim.lsp.util.make_position_params(nil, "utf-8")
  ---@cast params lsp.ReferenceParams
  params.context = { includeDeclaration = false }

  vim.lsp.buf_request(bufnr, "textDocument/references", params, function(err, result, _ctx, _config)
    if err or not result then
      vim.notify("Error getting references: " .. (err and err.message or "No result"), vim.log.levels.ERROR)
      return nil
    end

    local items = vim.tbl_map(function(ref)
      local filename = vim.uri_to_fname(ref.uri)
      local lnum = ref.range.start.line + 1
      local col = ref.range.start.character + 1
      return {
        filename = filename,
        lnum = lnum,
        col = col,
        text = string.format("%s:%d:%d",
          vim.fn.fnamemodify(filename, ":."),
          lnum,
          col)
      }
    end, result)

    local config = {
      source = {
        items = items,
        name = 'References',
        choose = function(item)
          vim.cmd("edit " .. item.filename)
          vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
        end,
      }
    }
    require("mini.pick").start(config)
  end)
end

-- Global on_attach function
M.on_attach = function(client, bufnr)
  local function buf_keymap(mode, keymap, callback)
    vim.keymap.set(mode, keymap, callback, { buffer = bufnr, noremap = true, silent = true })
  end

  local function buf_set_option(name, value)
    vim.api.nvim_set_option_value(name, value, { buf = bufnr })
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  buf_keymap("n", "gD", vim.lsp.buf.declaration)
  buf_keymap("n", "gd", vim.lsp.buf.definition)
  buf_keymap("n", "gi", vim.lsp.buf.implementation)
  buf_keymap("n", "gr", function() get_lsp_references(bufnr) end)
  buf_keymap("n", "K", vim.lsp.buf.hover)
  buf_keymap("n", "<C-k>", vim.lsp.buf.signature_help)
  buf_keymap("i", "<C-k>", vim.lsp.buf.signature_help)
  buf_keymap("n", "<leader>r", vim.lsp.buf.rename)
  buf_keymap("n", "<C-a>", vim.lsp.buf.code_action)

  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<leader>=", function()
      vim.lsp.buf.format({ timeout_ms = 5000 })
    end, { buffer = bufnr, noremap = true, silent = true })
  else
    vim.keymap.set("n", "<leader>=", function()
      require("conform").format({
        bufnr = bufnr,
        lsp_format = "fallback",
        quiet = true,
      })
    end, { buffer = bufnr, noremap = true, silent = true })
  end
  buf_keymap("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end)
  buf_keymap("n", "J", show_line_diagnostics)
  buf_keymap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
  buf_keymap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
end

return M

