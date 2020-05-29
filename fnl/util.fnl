(module util
  {:require {core aniseed.core
             str aniseed.string}})

(defn empty? [coll]
  (= (length coll) 0))

(defn mapcat [f xs]
  (core.concat
    (core.map f xs)))

(defn comp2 [f1 f2]
  (fn [x]
    (f1 (f2 x))))

(defn key2str [k]
  (: gsub (tostring k) "-" "_"))

(defn init
  [xs]
  (let [returned []
        len (- (length xs) 1)]
    (each [idx value (ipairs (unpack xs 1 len))]
      (set returned.idx value))
    returned))

(defn keys-in [m]
  (if (= (type m) "table")
    (mapcat (fn [[k v]]
              (let [sub (keys-in v)
                    nested (core.map
                             (fn [x] (into [(key2str k)] x))
                             (core.filter (comp2 not empty?) sub))]
                (if (not (empty? sub))
                  nested
                  [[(key2str k) v]])))
            m)
    []))

(defn flatten-config [m]
  (core.map (fn [line]
              (let [f (. line ":-1")
                    s (last line)]
                [(str.join "#" f) s]))
            (keys-in m)))

(flatten-config {:powerline-fonts false})

(deftest test-flatten-config
  (t.= (flatten-config
        {:powerline-fonts false
         :section_c "%>%f"
         :extensions {:branch {:enabled true}
                      :tabline {:enabled true
                                :buffer-idx-mode true}}}
        [["powerline_fonts" false]
         ["section_c" "%>%f"]
         ["extensions#branch#enabled" true]
         ["extensions#tabline#enabled" true]
         ["extensions#tabline#buffer-idx-mode" true]])))

