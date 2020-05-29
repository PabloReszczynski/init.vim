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
local flatten_config = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function flatten_config0(map)
      local function _3_(_4_0)
        local _5_ = _4_0
        local key = _5_[1]
        local value = _5_[2]
        if ("table" == type(value)) then
          return str.join("#", core.map(flatten_config0, value))
        else
          return tostring(value)
        end
      end
      return core.map(_3_, pairs(map))
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
    return t["="](flatten_config({["powerline-fonts"] = false, extensions = {branch = {enabled = true}, tabline = {["buffer-idx-mode"] = true, enabled = true}}, section_c = "%>%f"}, {{"powerline-fonts", false}, {"section_c", "%>%f"}, {"extensions#branch#enabled", true}, {"extensions#tabline#enabled", true}, {"extensions#tabline#buffer-idx-mode", true}}))
  end
  tests_23_0_["test-flatten-config"] = _3_
  _0_0["aniseed/tests"] = tests_23_0_
  return nil
end