return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "go", "css" },
                sync_install = false,
                highlight = { enable = true },
                ident = { enable = true }
            })
        end
    },
    -- {
    --     'windwp/nvim-autopairs',
    --     event = "InsertEnter",
    --     config = true
    --     -- use opts = {} for passing setup options
    --     -- this is equalent to setup({}) function
    -- },
    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        branch = 'v0.6', --recommended as each new version will have breaking changes
        opts = {
            --Config goes here
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup({})
        end
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                autotag = {
                    enable = true,
                }
            }
        end
    }
}
