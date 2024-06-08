return {
    'tpope/vim-fugitive',
    opts = {},
    config = function()
        vim.keymap.set("n", "<leader>v", vim.cmd.G)
        vim.keymap.set("n", "<leader>c", function()
            vim.cmd.G("commit")
        end)
    end
}
