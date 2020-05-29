local _0_0 = nil
do
  local name_23_0_ = "dotfiles.init"
  local loaded_23_0_ = package.loaded[name_23_0_]
  local module_23_0_ = nil
  if ("table" == type(loaded_23_0_)) then
    module_23_0_ = loaded_23_0_
  else
    module_23_0_ = {}
  end
  module_23_0_["aniseed/module"] = name_23_0_
  module_23_0_["aniseed/locals"] = (module_23_0_["aniseed/locals"] or {})
  module_23_0_["aniseed/local-fns"] = (module_23_0_["aniseed/local-fns"] or {})
  package.loaded[name_23_0_] = module_23_0_
  _0_0 = module_23_0_
end
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", nvim = "aniseed.nvim", nvim_lsp = "nvim_lsp"}}
  return {require("aniseed.core"), require("aniseed.nvim"), require("nvim_lsp")}
end
local _2_ = _1_(...)
local core = _2_[1]
local nvim = _2_[2]
local nvim_lsp = _2_[3]
do local _ = ({nil, _0_0, nil})[2] end
local on_attach = nil
do
  local v_23_0_ = nil
  local function on_attach0(_, bufnr)
    return nvim.buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end
  v_23_0_ = on_attach0
  _0_0["aniseed/locals"]["on-attach"] = v_23_0_
  on_attach = v_23_0_
end
local lsp_servers = nil
do
  local v_23_0_ = {"tsserver", "vimls", "jsonls", "rls", "pyls"}
  _0_0["aniseed/locals"]["lsp-servers"] = v_23_0_
  lsp_servers = v_23_0_
end
for _, lsp in ipairs(lsp_servers) do
  local lsp_setup = nvim_lsp[lsp]
  if lsp_setup then
    lsp_setup.setup({})
  end
end
nvim_lsp.hie.setup({languageServerHaskell = {["completionSnippetsOn:"] = true, ["formatOnImportOn:"] = true, ["formattingProvider:"] = "brittany", ["liquidOn:"] = false, hlintOn = true, maxNumberOfProblems = 10}})
nvim.g.ale_completion_enabled = 1
nvim.g["deoplete#enable_at_startup"] = 1
nvim.g["deoplete#enable_ignore_case"] = 1
nvim.g["context_filetype#same_filetypes"] = {}
local terminal_colors = nil
do
  local v_23_0_ = {blue = nvim.g.terminal_color_13, brown = nvim.g.terminal_color_9, green = nvim.g.terminal_color_11, lightblue = nvim.g.terminal_color_12, magenta = nvim.g.terminal_color_14, red = nvim.g.terminal_color_8, yellow = nvim.g.terminal_color_10}
  _0_0["aniseed/locals"]["terminal-colors"] = v_23_0_
  terminal_colors = v_23_0_
end
nvim.g.rbt_max = 8
nvim.g.rbpt_colorpairs = {{"red", terminal_colors.red}, {"brown", terminal_colors.brown}, {"yellow", terminal_colors.yellow}, {"green", terminal_colors.green}, {"lightblue", terminal_colors.lightblue}, {"blue", terminal_colors.blue}, {"magenta", terminal_colors.magenta}, {"brown", nvim.g.terminal_color_15}}
nvim.g.tmuxline_separators = {left = "", left_alt = "|", right = "", right_alt = "|", space = " "}
nvim.g.tmuxline_theme = "gruvbox"
nvim.g.airline_powerline_fonts = 0
nvim.g.airline_section_c = "%>%f"
nvim.g["airline#extension#branch#enabled"] = 1
nvim.g["airline#extension#tabline#enabled"] = 1
nvim.g["airline#extension#tabline#buffer_idx_mode"] = 1
nvim.g["airline#extension#tabline#show_tabs"] = 1
nvim.g["airline#extension#tabline#fnamemod"] = ":t"
nvim.g["airline#extension#tabline#show_close_button"] = 1
nvim.g["airline#extension#fugitiveline#enabled"] = 1
nvim.g["airline#extension#hunks#enabled"] = 0
nvim.g["airline#extension#ale#enabled"] = 1
nvim.g.ale_rust_rls_toolchain = "nightly"
nvim.g.ale_rust_rls_config = {rust = {clippy_preference = "on"}}
nvim.g.lsp_diagnostics_enabled = 1
nvim.g.ale_set_ballons = 1
nvim.g.ale_fixers = {clojure = {"lein cljfmt fix"}, graphql = {"prettier"}, haskell = {"brittany"}, javacriptreact = {"eslint", "prettier"}, javascript = {"eslint", "prettier"}, json = {"prettier"}, python = {"autopep8"}, rust = {"rustfmt"}, scala = {"scalafmt"}, typescript = {"eslint", "tslint", "prettier"}, yaml = {"prettier"}}
nvim.g.ale_linters = {clojure = {"clj-kondo"}, haskell = {"hie", "brittany", "liquid"}, javascript = {"flow", "eslint", "tslint", "prettier"}, javascriptreact = {"flow", "eslint", "prettier"}, json = {"jsonls"}, python = {"pyls"}, rust = {"rls", "clippy"}, sbt = {"metals-vim"}, scala = {"metals-vim"}, vim = {"vimls"}}
nvim.g.slime_target = "tmux"
nvim.g.slime_default_config = {socket_name = "default", target_pane = "{right-of}"}
return nil