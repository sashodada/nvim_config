local v = require'utils.vim'

require'nvim-tree'.setup({
    view = {
        mappings = {
            list = {
                { key = "<C-e>", action = "" }
            }
        }
    }
})

local nvim_tree_group = vim.api.nvim_create_augroup('NvimTree', {clear = true})
local cmdopts = {silent = true}
v.multiautocmd(
    {
        { 'BufEnter', function() v.map('n', '<C-e>', ':NvimTreeClose<CR>', cmdopts) end},
        { 'BufLeave', function() v.multimap({'n', 'v'}, '<C-e>', ':NvimTreeFocus<CR>', cmdopts) end},
    },
    nvim_tree_group,
    'NvimTree_*'
)

