-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local icons = require('icons')
require('telescope.config')
require('telescope.mappings')
local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        sorting_strategy = 'ascending',
        selection_strategy = 'reset',
        scroll_strategy = 'limit',
        layout_strategy = 'horizontal',
        layout_config = {
            prompt_position = 'top',
            width = 0.6,
            height = 0.6,
        },
        winblend = 0,
        prompt_prefix = icons.ui.Search .. ' ',
        selection_caret = icons.ui.Forward .. ' ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        border = true,
        preview = false,
        path_display = 'truncate',
        file_ignore_patterns = {
            'node_modules',
            '.git',
        },
        mappings = {
            i = {
                ['<C-u>'] = actions.results_scrolling_up,
                ['<C-d>'] = actions.results_scrolling_down,
            },
            n = {
                ['<C-d>'] = actions.results_scrolling_down,
                ['<C-u>'] = actions.results_scrolling_up,
                ['<C-c>'] = actions.close,
            },
        },
    },
}

local builtin = require('telescope.builtin')

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

local map = vim.keymap.set

-- See `:help telescope.builtin`
map('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

