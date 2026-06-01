vim.cmd([[set termguicolors]])

require("plugins")

local set = vim.opt

-- Space is leader key
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard
set.clipboard = "unnamedplus"

-- Folding
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldtext = ""
set.foldlevel = 99
--set.foldlevelstart = 0
set.foldnestmax = 4

-- Mappings

vim.keymap.set("n", "<Leader><Tab>", ":b<CR>", { noremap = true })

-- Telescope
-- vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files, { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files, { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>fb", require("telescope.builtin").buffers, { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>fa", require("telescope.builtin").live_grep, { noremap = true, silent = true })
-- vim.keymap.set("n", "<Leader>fh", require("telescope.builtin").search_history, { noremap = true, silent = true })
-- vim.keymap.set("n", "z=", require("telescope.builtin").spell_suggest, { noremap = true, silent = true })
-- MiniPick
local MiniPick = require("mini.pick")
MiniPick.setup()
vim.keymap.set("n", "<Leader>ff",
  function()
    MiniPick.builtin.files({ tool = "fd" })
  end,
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>fb", function()
    MiniPick.builtin.buffers({
      sort = function(a, b)
        return a.modified > b.modified
      end,
    })
  end,
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<Leader>fa",
  function()
    MiniPick.builtin.grep_live({ tool = "rg" })
  end,
  { noremap = true, silent = true }
)

-- NvimTree
vim.keymap.set("n", "<Leader>ft", ":NvimTreeToggle<cr>", { noremap = true, silent = true })

-- UI
set.hidden = true
set.signcolumn = "yes"
set.cmdheight = 2
set.showtabline = 0
set.showcmd = true
set.wildmenu = true
set.wildmode = { "list:longest", "full" }
set.ruler = true
set.laststatus = 3
set.showmode = false
set.diffopt:append({ linematch = 60, algorithm = "patience", "vertical" })
set.eb = false
set.inccommand = "nosplit"

-- Completion
set.complete = set.complete:append({ "i" })
set.path = set.path:append({ "**" })

-- Line numbers
set.number = true
set.relativenumber = true

local number_toggle_group = vim.api.nvim_create_augroup("LineNumberToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = number_toggle_group,
  callback = function()
    set.relativenumber = false
  end,
});

vim.api.nvim_create_autocmd("InsertLeave", {
  group = number_toggle_group,
  callback = function()
    set.relativenumber = true
  end,
});

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
  group = number_toggle_group,
  callback = function()
    if vim.fn.mode() ~= "i" then
      set.relativenumber = true
    end
  end
})


vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
  group = number_toggle_group,
  callback = function()
    set.relativenumber = false
  end
})

-- Cursorline
set.cursorline = true

-- Search
set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.showmatch = true
set.path = "**"

-- Turn off search highlight
vim.keymap.set("n", "//", ":noh<CR>")

-- Ignore these files
set.wildignore = {
  "*.zip",
  "*.png",
  "*.gif",
  "*.pdf",
  "*DS_Stores*",
  "*/.git/*",
  "*/node_modules/*",
  "yarn.lock",
  "package-lock.json",
  "pnpm-lock.yaml",
}

-- Quickscope
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- Highlight Lsp Inlay Hints
vim.cmd("hi! link LspInlayHint LspInfoTip")

-- Movement
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })
set.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- Editor
set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.autoindent = true
set.smartindent = true
set.scrolloff = 5
set.wildignorecase = true
set.wrap = true

-- Column
set.textwidth = 0
set.colorcolumn = "80"

-- System
set.encoding = "utf8"
set.backup = false
set.swapfile = false
set.ffs = { "unix", "dos", "mac" }
set.updatetime = 250
set.undofile = true
set.undolevels = 10000
set.history = 10000
set.backspace = { "indent", "eol", "start" }
set.ttimeout = true
set.ttimeoutlen = 0

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = ":%s/\\s\\+$//e"
})

-- Show whitespaces
set.list = true
set.listchars = {
  tab = "-->",
  eol = "¬",
  extends = "↩",
  precedes = "↪",
  trail = "·",
}

-- Autoreload
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { os.getenv("MYVIMRC") },
  command = ":luafile $MYVIMRC",
})

-- Fountain mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fountain" },
  callback = function()
    vim.cmd("setlocal ft=markdown")
    vim.cmd("setlocal spell")
    vim.cmd("setlocal spelllang=en_us")
    vim.cmd("ZenMode")
  end
})

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line diagnostics
local show_line_diagnostics = function()
  vim.diagnostic.open_float({
    focusable = false,
    width = 80,
  })
end

-- Providers
vim.g.loaded_perl_provider = 0    -- Disable Perl
vim.g.loaded_node_provider = 0    -- Disable Node
vim.g.loaded_python3_provider = 0 -- Disable Python
vim.g.loaded_ruby_provider = 0    -- Disable Ruby

-- LSP Configuration

require("lsp").setup()

vim.opt.winbar =
"%#WinBarSeparator# %*%#WinBarContent#%f%*%#WinBarSeparator# %*"


-- vim.keymap.set("n", "[c", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = true })

-- Opam User setup
function Setup_opam()
  local opam_share_dir = vim.system({ "opam", "config", "var", "share" }):wait().stdout:gsub("[\r\n]*$", "")
  local opam_configuration = {
    ["ocp-indent"] = function()
      vim.api.nvim_exec2("set rtp^=" .. opam_share_dir .. "/ocp-indent/vim", {})
    end,
    ["ocp-index"] = function()
      vim.api.nvim_exec2("set rtp^=" .. opam_share_dir .. "/ocp-index/vim", {})
    end,
    ["merlin"] = function()
      local dir = opam_share_dir .. "/merlin/vim"
      vim.api.nvim_exec2("set rtp^=" .. dir, {})
    end
  }
  local opam_check_cmdline = {
    "opam",
    "list",
    "--installed",
    "--short",
    "--sage",
    "--color=never",
    "ocp-indent",
    "ocp-index",
    "merlin"
  }
  local opam_available_tools = vim.system(opam_check_cmdline):wait().stdout:gmatch("([^\n]+)")
  for tool in opam_available_tools do
    if opam_configuration[tool] then
      opam_configuration[tool]()
    end
  end
  vim.api.source("~/.opam/default/share/ocp-indent/vim/indent/ocaml.vim")
end

-- Local note taking plugin
-- local log_notes = require("log_notes")
-- log_notes.setup()
--
-- -- Autocommand to enable timestamps for Markdown files in ~/notes/
-- vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = "~/notes/*.md",
--     callback = function()
--         log_notes.toggle()
--     end
-- })

-- FT Leap
do
  local function as_ft (key_specific_args)
    local common_args = {
      inputlen = 1,
      inclusive = true,
      opts = {
        labels = "",
        safe_labels = vim.fn.mode(1):match'[no]' and '' or nil,
      },
    }
    return vim.tbl_deep_extend('keep', common_args, key_specific_args)
  end

  local clever = require("leap.user").with_traversal_keys
  local clever_f = clever("f", "F")
  local celver_t = clever("t", "T")

  for key, key_specific_args in pairs {
    f = { opts = clever_f, },
    F = { backwards = true, opts = clever_f, },
    t = { opts = celver_t, },
    T = { backwards = true, opts = celver_t, },
  } do
    vim.keymap.set({ "n", "x", "o" }, key, function ()
      require("leap").leap(as_ft(key_specific_args))
    end)
  end
end

-- Custom filetypes
--
-- Github Actions
vim.filetype.add({
  pattern = {
    [".*/%.github.com/workflows/.*%.ya?ml"] = "yaml.ghaction",
    [".*/%.github/actions/.*/action%.ya?ml"] = "yaml.ghaction"
  },
})

-- Copy visual selection as `file/path(line_number)`
vim.keymap.set('v', '<leader>cf', function()
  local start_line = vim.fn.getpos("'<")[2]
  local end_line   = vim.fn.getpos("'>")[2]
  local path = vim.fn.expand('%')
  local ref = start_line == end_line
    and (path .. '(' .. start_line .. ')')
    or  (path .. '(' .. start_line .. '-' .. end_line .. ')')
  vim.fn.setreg('+', ref)
  vim.fn.setreg('"', ref)
  vim.notify('Copied: ' .. ref, vim.log.levels.INFO)
end, { desc = 'Copy file ref with line range' })
