local _0_0 = nil
do
  local name_0_ = "dotfiles.init"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {require("aniseed.core"), require("diagnostic"), require("aniseed.nvim"), require("nvim_lsp"), require("nvim-treesitter.configs")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {["treesitter-config"] = "nvim-treesitter.configs", core = "aniseed.core", diagnostic = "diagnostic", nvim = "aniseed.nvim", nvim_lsp = "nvim_lsp"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _1_ = _2_(...)
local core = _1_[1]
local diagnostic = _1_[2]
local nvim = _1_[3]
local nvim_lsp = _1_[4]
local treesitter_config = _1_[5]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "dotfiles.init"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local lsp_servers = nil
do
  local v_0_ = {"tsserver", "rls", "pyls", "dartls", "hls"}
  _0_0["aniseed/locals"]["lsp-servers"] = v_0_
  lsp_servers = v_0_
end
for _, lsp in ipairs(lsp_servers) do
  local lsp_setup = nvim_lsp[lsp]
  if lsp_setup then
    lsp_setup.setup({on_attach = diagnostic.on_attach})
  end
end
nvim.g.ale_completion_enabled = 1
nvim.g["deoplete#enable_at_startup"] = 1
nvim.g["deoplete#enable_ignore_case"] = 1
nvim.g["context_filetype#same_filetypes"] = {}
local terminal_colors = nil
do
  local v_0_ = {blue = nvim.g.terminal_color_13, brown = nvim.g.terminal_color_9, green = nvim.g.terminal_color_11, lightblue = nvim.g.terminal_color_12, magenta = nvim.g.terminal_color_14, red = nvim.g.terminal_color_8, yellow = nvim.g.terminal_color_10}
  _0_0["aniseed/locals"]["terminal-colors"] = v_0_
  terminal_colors = v_0_
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
nvim.g.ale_fixers = {clojure = {"lein cljfmt fix"}, dart = {"dartfmt"}, graphql = {"prettier"}, haskell = {"brittany"}, javacriptreact = {"eslint", "prettier"}, javascript = {"eslint", "prettier"}, json = {"prettier"}, python = {"autopep8"}, rust = {"rustfmt"}, scala = {"scalafmt"}, tex = {"latexindent"}, typescript = {"eslint", "tslint"}, typescriptreact = {"eslint", "tslint", "prettier"}, yaml = {"prettier"}}
nvim.g.ale_linters = {clojure = {"clj-kondo"}, dart = {"dartanalyzer"}, haskell = {"hie", "brittany", "liquid"}, javascript = {"flow", "eslint", "tslint"}, javascriptreact = {"flow", "eslint", "prettier"}, json = {"jsonls"}, python = {"pyls"}, rust = {"rls", "clippy"}, sbt = {"metals-vim"}, scala = {"metals-vim"}, tex = {"texlab"}, typescript = {"tsserver"}, vim = {"vimls"}}
nvim.g.slime_target = "tmux"
nvim.g.slime_default_config = {socket_name = "default", target_pane = "{right-of}"}
return treesitter_config.setup({ensure_installed = "maintained", highlight = {enable = true}, textobjects = {lsp_interop = {enable = true, peek_definition_code = {[{"df"}] = "@function.outer"}}, move = {enable = true, goto_next_end = {[{"]M"}] = "@function.outer"}, goto_next_start = {[{"]m"}] = "@function.outer"}, goto_previous_end = {[{"[M"}] = "@function.outer"}, goto_previous_start = {[{"[m"}] = "@function.outer"}}}})