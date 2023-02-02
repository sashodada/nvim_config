local M = {}
local map = vim.api.nvim_set_keymap
local function multimap(modes, lhs, rhs, opts)
    for _, mode in pairs(modes) do
        map(mode, lhs, rhs, opts)
    end
end

local unmap = vim.api.nvim_del_keymap

local create_autogrp = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local function multiautocmd(event_callbacks, group, pattern)
  for _, event_callback in pairs(event_callbacks) do
    local event, callback = unpack(event_callback)
    create_autocmd(event, {
      callback = callback,
      group = group,
      pattern = pattern
    })
  end
end

M = {
  map = map,
  unmap = unmap,
  multimap = multimap,
  create_autogrp = create_autogrp,
  create_autocmd = create_autocmd,
  multiautocmd = multiautocmd,
}

return M
