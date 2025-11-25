-- Python filetype plugin

-- Buffer-local settings
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.textwidth = 0
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.fileformat = "unix"
vim.wo.colorcolumn = "80"
-- Remove ':' from indentkeys (indentkeys-=:)
vim.opt_local.indentkeys:remove(":")

-- Setup LSP
require("languages.python").setup()

