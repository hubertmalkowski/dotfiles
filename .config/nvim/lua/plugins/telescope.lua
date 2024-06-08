return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>s', builtin.find_files, {})
            vim.keymap.set('n', '<leader>f', builtin.git_files, {})
            vim.keymap.set('n', '<leader>d', builtin.buffers, {})
            vim.keymap.set('n', '<leader>g', builtin.live_grep)


            vim.keymap.set('n', '<leader>p', require 'telescope'.extensions.projects.projects, {})
        end
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }


}
