local M = {}

local function map(t, f)
    local res = {}
    for k, v in pairs(t) do
        res[k] = f(v)
    end
    return res
end

local function strToArray(str)
  local t = {}
  for i = 1, #str do
    t[i] = string.sub(str, i, i)
  end
  return t
end

M = {
  map = map,
  strToArray = strToArray,
}

return M

