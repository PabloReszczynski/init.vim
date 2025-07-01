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
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldtext = ""
set.foldlevel = 99
--set.foldlevelstart = 0
set.foldnestmax = 4

-- Mappings

vim.keymap.set("n", "<Leader><Tab>", ":b<CR>", { noremap = true })

-- Telescope
vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fb", require("telescope.builtin").buffers, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fa", require("telescope.builtin").live_grep, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fh", require("telescope.builtin").search_history, { noremap = true, silent = true })
vim.keymap.set("n", "z=", require("telescope.builtin").spell_suggest, { noremap = true, silent = true })

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
--set.nu = set.rnu:get()
set.rnu = true
local number_toggle_group = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = number_toggle_group,
  callback = function()
    if vim.opt.nu:get() and vim.api.mode() ~= "i" then
      vim.opt.rnu = true
    end
  end
})


vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = number_toggle_group,
  callback = function()
    if vim.opt.nu:get() then
      vim.opt.rnu = false
    end
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
  callback = function ()
    vim.cmd("setlocal ft=markdown")
    vim.cmd("setlocal spell")
    vim.cmd("setlocal spelllang=en_us")
    vim.cmd("ZenMode")
  end
})

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("impatient") -- Setup a cache for faster startup

-- Treesitter
local treesitter_config = require("nvim-treesitter.configs")
local treesitter_install = require("nvim-treesitter.install")

-- Line diagnostics
local show_line_diagnostics = function()
  vim.diagnostic.open_float({
    focusable = false,
    width = 80,
  })
end

-- LSP Configuration

require("lsp").setup()

-- @
treesitter_config.setup({
  incremental_selection = { enable = true },
  ignore_install = { "latex" },
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
})

treesitter_install.prefer_git = true
treesitter_install.compilers = { "gcc-14" }

-- nvim.api.nvim_command('autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()')

vim.opt.winbar =
"%#WinBarSeparator# %*%#WinBarContent#%f%*%#WinBarSeparator# %*"


vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

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
