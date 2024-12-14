return {
  'folke/snacks.nvim',
  keys = {
    {
      '<leader>gl',
      function()
        require('snacks').lazygit()
      end,
      desc = '[G]it [L]azy',
    },
  },
  opts = {
    lazygit = {},
  },
}
