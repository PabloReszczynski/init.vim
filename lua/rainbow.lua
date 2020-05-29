local _0_0 = nil
do
  local name_23_0_ = "rainbow"
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
  _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", nvim = "aniseed.nvim"}}
  return {require("aniseed.core"), require("aniseed.nvim")}
end
local _2_ = _1_(...)
local core = _2_[1]
local nvim = _2_[2]
do local _ = ({nil, _0_0, nil})[2] end
local colors = nil
do
  local v_23_0_ = {DarkBlue = "SeaGreen2", Darkblue = "firebrick3", black = "SeaGreen3", brown = "firebrick3", darkcyan = "SeaGreen3", darkgray = "DarkOrchid3", darkgreen = "RoyalBlue3", darkmagenta = "DarkOrchid3", darkred = "DarkOrchid3", gray = "RoyalBlue3", red = "firebrick3"}
  _0_0["aniseed/locals"]["colors"] = v_23_0_
  colors = v_23_0_
end
return nil