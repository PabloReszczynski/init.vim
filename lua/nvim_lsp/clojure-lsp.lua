local configs = require 'nvim_lsp/configs'
local util = require 'nvim_lsp/util'

configs["clojure-lsp"] = {
  default_config = {
    cmd = { "clojure-lsp" };
    filetypes = { "clojure", "clojurescript" };
    root_dir = util.root_pattern("deps.edn", "project.clj", "boot.clj", "shadow-cljs.edn")
  };

  docs = {
    description = [[
      https://github.com/snoe/clojure-lsp
    ]];
  };
}
