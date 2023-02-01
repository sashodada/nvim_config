require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            -- statusline = { "packer" },
        },
        globalstatus = true,
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1,
            }
        },
    },
}

print(vim.inspect(require('lualine')))
