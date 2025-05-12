return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup {
      preset = 'helix',
      win = {
        padding = { 2, 6 },
      },
      icons = {
        breadcrumb = '»',
        separator = '  ',
        group = '',
      },
    }

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', group = '(C)ode' },
      { '<leader>a', group = '(A)I', icon = '' },
      { '<leader>d', group = '(D)ebugger', icon = '' },
      { '<leader>s', group = '(S)earch' },
      { '<leader>w', group = '(W)orkspace' },
      { '<leader>t', group = '(T)oggle' },
      { '<leader>l', group = '(L)ang specific' },
      { '<leader>g', group = '(G)it' },
      { '<leader>n', group = '(N)eotest' },
      { '<leader>h', group = '(H)' },
    }
  end,
}
