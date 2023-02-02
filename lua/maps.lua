local uv = require'utils.vim'
local f = require'utils.functional'

vim.g.mapleader = ';'

local silent = { silent = true, noremap = true }
local silentexpr = { expr = true, silent = true, noremap = true }
local noremap = { noremap = true }

uv.map('i', 'jj', '<ESC>', noremap)
uv.map('n', '<leader>c', ':noh <CR>', noremap)
uv.multimap({'n', 'v'}, '<C-e>', ':NvimTreeFocus<CR>', noremap)

-- Keymaps for better default experience
-- See `:help uv.keymap.set()`
uv.multimap({'n', 'v'}, '<Space>', '<Nop>', silent)

-- Remap for dealing with word wrap
uv.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", silentexpr)
uv.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", silentexpr)

-- Split management
local splitMaps = { ['=']='+', [',']='<', ['.']='>'}
for _, l in pairs(f.strToArray('svhjkl-r')) do
    splitMaps[l] = '<Esc><C-w>'..l
end

for k, v in pairs(splitMaps) do
    uv.map('n', '<A-'..k..'>', '<C-w>'..v, silent)
    uv.map('t', '<A-'..k..'>', '<C-\\><C-n><C-w>'..v, silent)
end
uv.map('n', '<A-q>', ':conf q<CR>', silent)
uv.map('n', '<C-q>', ':conf qa<CR>', silent)


-- Misc
uv.map('t', '<Esc>', '<C-\\><C-n>', silent)

-- [[ Highlight on yank ]]
-- See `:help uv.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

