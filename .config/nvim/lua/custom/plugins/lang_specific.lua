return {
  -- RUBY
  {
    'tpope/vim-rails',
    ft = { 'ruby', 'eruby' },
    config = function()
      local wk = require 'which-key'
      wk.add {
        {
          '<leader>r',
          group = '[R]ails',
        },
      }
    end,
    keys = {
      {
        '<leader>rm',
        '<cmd>Emodel<CR>',
        desc = '[R]ails [M]odel',
      },
      {
        '<leader>rc',
        '<cmd>Econtroller<CR>',
        desc = '[R]ails [C]ontroller',
      },
      {
        '<leader>rv',
        '<cmd>Eview<CR>',
        desc = '[R]ails [V]iew',
      },
    },
  },
}
