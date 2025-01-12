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
    {
      '<leader>tz',
      function()
        require('snacks').zen()
      end,
      desc = '[T]oggle [Z]en',
    },
  },
  opts = {
    lazygit = {
      wo = {
        winhighlight = 'NormalFloat:Transparent',
      },
    },
    zen = {
      toggles = {
        dim = false,
        git_signs = false,
        mini_diff_signs = false,
      },
      win = {
        style = {
          enter = true,
          fixbuf = false,
          minimal = false,
          width = 120,
          height = 0,
          backdrop = { transparent = false, blend = 0, bg = '#080808' },
          keys = { q = false },
          zindex = 40,
          wo = {
            winhighlight = 'NormalFloat:Normal',
          },
        },
        -- style = 'dashboard',
      },
    },
  },
}
