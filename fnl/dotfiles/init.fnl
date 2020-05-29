(module dotfiles.init
  {require {core aniseed.core
            nvim aniseed.nvim
            nvim_lsp "nvim_lsp"}})

;; LSP settings
(defn- on-attach [_ bufnr]
  (nvim.buf_set_option bufnr "omnifunc" "v:lua.vim.lsp.omnifunc"))

(def- lsp-servers ["tsserver" "vimls" "jsonls" "rls" "pyls"])

(each [_ lsp (ipairs lsp-servers)]
  (let [lsp-setup (. nvim_lsp lsp)]
    (when lsp-setup
      (lsp-setup.setup {})))) ;; {:on_attach on-attach}))))

(nvim_lsp.hie.setup { ;; :on_attach on-attach
                     :languageServerHaskell
                     {:hlintOn true
                      :maxNumberOfProblems 10
                      :liquidOn: false
                      :completionSnippetsOn: true
                      :formatOnImportOn: true
                      :formattingProvider: "brittany"}})


;; Deoplete
(set nvim.g.ale_completion_enabled 1)
(set nvim.g.deoplete#enable_at_startup 1)
(set nvim.g.deoplete#enable_ignore_case 1)
(set nvim.g.context_filetype#same_filetypes {})
;(set nvim.g.context_filetype#same_filetypes._ ' ')

(def- terminal-colors
  {:red       nvim.g.terminal_color_8
   :brown     nvim.g.terminal_color_9
   :yellow    nvim.g.terminal_color_10
   :green     nvim.g.terminal_color_11
   :lightblue nvim.g.terminal_color_12
   :blue      nvim.g.terminal_color_13
   :magenta   nvim.g.terminal_color_14})

;; Rainbow Parens
(set nvim.g.rbt_max 8)
(set nvim.g.rbpt_colorpairs
     [["red"       (. terminal-colors :red)]
      ["brown"     (. terminal-colors :brown)]
      ["yellow"    (. terminal-colors :yellow)]
      ["green"     (. terminal-colors :green)]
      ["lightblue" (. terminal-colors :lightblue)]
      ["blue"      (. terminal-colors :blue)]
      ["magenta"   (. terminal-colors :magenta)]
      ["brown"     nvim.g.terminal_color_15]])

;; Tmuxline
(set nvim.g.tmuxline_separators
     {:left ""
      :left_alt "|"
      :right ""
      :right_alt "|"
      :space " "})
(set nvim.g.tmuxline_theme "gruvbox")

;; Airline config

; (defn- set-global-config [prefix config-map]
;   (each [key auch (pairs config-map)]))

; (def airline-config
;   {:powerline-fonts false
;    :section_c       "%>%f"
;    :extensions      {:branch       {:enabled true}
;                      :tabline      {:enabled true
;                                     :buffer-idx-mode true
;                                     :show-tabs true
;                                     :fnamemod ":t"
;                                     :close-button true}
;                      :fugitiveline {:enabled true}
;                      :hunks        {:enabled false}
;                      :ale          {:enabled true}}})

(set nvim.g.airline_powerline_fonts 0)
(set nvim.g.airline_section_c "%>%f")
(set nvim.g.airline#extension#branch#enabled 1)
(set nvim.g.airline#extension#tabline#enabled 1)
(set nvim.g.airline#extension#tabline#buffer_idx_mode 1)
(set nvim.g.airline#extension#tabline#show_tabs 1)
(set nvim.g.airline#extension#tabline#fnamemod ":t")
(set nvim.g.airline#extension#tabline#show_close_button 1)
(set nvim.g.airline#extension#fugitiveline#enabled 1)
(set nvim.g.airline#extension#hunks#enabled 0)
(set nvim.g.airline#extension#ale#enabled 1)

;; ALE Config

; Rust
(set nvim.g.ale_rust_rls_toolchain "nightly")
(set nvim.g.ale_rust_rls_config
     {:rust {:clippy_preference "on"}})

; Haskell

; Global
(set nvim.g.lsp_diagnostics_enabled 1)
(set nvim.g.ale_set_ballons 1)

(set nvim.g.ale_fixers
     {:javascript ["eslint" "prettier"]
      :javacriptreact ["eslint" "prettier"]
      :typescript ["eslint" "tslint" "prettier"]
      :json ["prettier"]
      :graphql ["prettier"]
      :rust ["rustfmt"]
      :scala ["scalafmt"]
      :clojure ["lein cljfmt fix"]
      :yaml ["prettier"]
      :haskell ["brittany"]
      :python ["autopep8"]})

(set nvim.g.ale_linters
     {:rust ["rls" "clippy"]
      :javascript ["flow" "eslint" "tslint" "prettier"]
      :javascriptreact ["flow" "eslint" "prettier"]
      :scala ["metals-vim"]
      :sbt ["metals-vim"]
      :clojure ["clj-kondo"]
      :haskell ["hie" "brittany" "liquid"]
      :vim ["vimls"]
      :json ["jsonls"]
      :python ["pyls"]})

; Slime
(set nvim.g.slime_target "tmux")
(set nvim.g.slime_default_config
     {:socket_name "default"
      :target_pane "{right-of}"})
