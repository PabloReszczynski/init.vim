local _0_0 = nil
do
  local name_23_0_ = "util"
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
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", str = "aniseed.string"}}
  return {require("aniseed.core"), require("aniseed.string")}
end
local _2_ = _1_(...)
local core = _2_[1]
local str = _2_[2]
do local _ = ({nil, _0_0, nil})[2] end
local empty_3f = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function empty_3f0(coll)
      return (#coll == 0)
    end
    v_23_0_0 = empty_3f0
    _0_0["empty?"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["empty?"] = v_23_0_
  empty_3f = v_23_0_
end
local mapcat = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function mapcat0(f, xs)
      return core.concat(core.map(f, xs))
    end
    v_23_0_0 = mapcat0
    _0_0["mapcat"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["mapcat"] = v_23_0_
  mapcat = v_23_0_
end
local comp2 = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function comp20(f1, f2)
      local function _3_(x)
        return f1(f2(x))
      end
      return _3_
    end
    v_23_0_0 = comp20
    _0_0["comp2"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["comp2"] = v_23_0_
  comp2 = v_23_0_
end
local key2str = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function key2str0(k)
      return gsub[tostring(k)](gsub, "-", "_")
    end
    v_23_0_0 = key2str0
    _0_0["key2str"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["key2str"] = v_23_0_
  key2str = v_23_0_
end
local init = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function init0(xs)
      local returned = {}
      local len = (#xs - 1)
      for idx, value in ipairs(unpack(xs, 1, len)) do
        returned.idx = value
      end
      return returned
    end
    v_23_0_0 = init0
    _0_0["init"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["init"] = v_23_0_
  init = v_23_0_
end
local keys_in = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function keys_in0(m)
      if (type(m) == "table") then
        local function _3_(_4_0)
          local _5_ = _4_0
          local k = _5_[1]
          local v = _5_[2]
          do
            local sub = keys_in0(v)
            local nested = nil
            local function _6_(x)
              return into({key2str(k)}, x)
            end
            nested = core.map(_6_, core.filter(comp2(__fnl_global__not, empty_3f), sub))
            if not empty_3f(sub) then
              return nested
            else
              return {{key2str(k), v}}
            end
          end
        end
        return mapcat(_3_, m)
      else
        return {}
      end
    end
    v_23_0_0 = keys_in0
    _0_0["keys-in"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["keys-in"] = v_23_0_
  keys_in = v_23_0_
end
local flatten_config = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function flatten_config0(m)
      local function _3_(line)
        local f = line[":-1"]
        local s = last(line)
        return {str.join("#", f), s}
      end
      return core.map(_3_, keys_in(m))
    end
    v_23_0_0 = flatten_config0
    _0_0["flatten-config"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["flatten-config"] = v_23_0_
  flatten_config = v_23_0_
end
flatten_config({["powerline-fonts"] = false})
do
  local tests_23_0_ = (_0_0["aniseed/tests"] or {})
  local function _3_(t)
    return t["="](flatten_config({["powerline-fonts"] = false, extensions = {branch = {enabled = true}, tabline = {["buffer-idx-mode"] = true, enabled = true}}, section_c = "%>%f"}, {{"powerline_fonts", false}, {"section_c", "%>%f"}, {"extensions#branch#enabled", true}, {"extensions#tabline#enabled", true}, {"extensions#tabline#buffer-idx-mode", true}}))
  end
  tests_23_0_["test-flatten-config"] = _3_
  _0_0["aniseed/tests"] = tests_23_0_
  return nil
end