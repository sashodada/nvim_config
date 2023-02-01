local u = require'utils'

vim.g.mapleader = ';'

u.map('i', 'jj', '<ESC>', {noremap = true})
u.map('n', '<leader>c', ':noh <CR>', {noremap = true})
u.multimap({'n', 'v'}, '<C-e>', ':NvimTreeFocus<CR>', {noremap = true})

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
u.multimap({'n', 'v'}, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
u.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
u.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

