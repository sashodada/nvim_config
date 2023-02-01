local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    -- vim.cmd [[packadd packer.nvim]] -- commented to hide error
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Let packer manage itself

    use "EdenEast/nightfox.nvim" -- Fancy dark theme
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline

    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    use { -- LSP Configuration & Plugins
       'neovim/nvim-lspconfig',
        requires = {
          -- Automatically install LSPs to stdpath for neovim
          'williamboman/mason.nvim',
          'williamboman/mason-lspconfig.nvim',
          'j-hui/fidget.nvim', -- Useful status updates for LSP
          'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing
        },
    }

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'

    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    use 'windwp/nvim-autopairs'

    use {
      'sudormrfbin/cheatsheet.nvim',

      requires = {
        {'nvim-telescope/telescope.nvim'},
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
      }
    }

    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require('packer').sync()
    end
end)

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed   '
    print '    Wait until Packer completes,  '
    print '       then restart nvim          '
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspRestart | PackerCompile',
    group = packer_group,
    pattern = { 'plugins.lua', '**/setup/*.lua', 'settings.lua' }
})

require('setup.theme')
require('setup.lualine')
require('setup.mason')
require('setup.comment')
require('setup.indent_blankline')
require('setup.gitsigns')
require('setup.telescope')
require('setup.treesitter')
require('setup.diagnostics')
require('setup.mason')
require('setup.fidget')
require('setup.cmp')
require('setup.autopairs')
require('setup.nvim-tree')
require('setup.auto-session')

--[[
DONE:
- telescope
- nvim-autopairs
- fidget
- comment
- indent_blankling
- vim-sleuth

- mason
- mason-lspconfig
- neodev
- nvim-lspconfig

- telescope-extensions
- session / project managemr

TODO:
- file tree

- fugitive
- rhubarb
- gitsigns

- nvim-cmp
- alpha

INSTALL:

]]--

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
