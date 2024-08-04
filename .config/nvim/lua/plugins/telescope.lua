return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            local utils = require('telescope.utils')
            vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {})
            vim.keymap.set('n', '<leader>S', builtin.lsp_workspace_symbols, {})

            vim.keymap.set('n', '<leader>f',
                function()
                    local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
                    if ret == 0 then
                        builtin.git_files()
                    else
                        builtin.find_files()
                    end
                end
                , {})

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
