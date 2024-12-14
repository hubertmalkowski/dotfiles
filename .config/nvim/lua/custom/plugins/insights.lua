return {
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>tp',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = '[T]oggle [P]roblems',
      },
      {
        '<leader>dd',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = '[D]ocument [D]iagnostics',
      },
    },
  },
  {
    'hedyhli/outline.nvim',
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set('n', '<leader>do', '<cmd>Outline<CR>', { desc = '[D]ocument [O]utline' })
      require('outline').setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
}
