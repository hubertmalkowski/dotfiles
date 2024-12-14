return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'jfpedroza/neotest-elixir',
  },
  config = function()
    local neotest = require 'neotest'
    neotest.setup {
      adapters = {
        require 'neotest-vitest',
        require 'neotest-elixir',
      },
    }

    vim.keymap.set('n', '<leader>nf', function()
      neotest.run.run(vim.fn.expand '%')
    end, {
      desc = '[N]eotest Test[f]ile',
    })

    vim.keymap.set('n', '<leader>nt', neotest.run.run, {
      desc = '[N]eotest nearest [T]est',
    })

    vim.keymap.set('n', '<leader>no', neotest.output_panel.toggle, {
      desc = '[N]eotest toggle [O]utput panel',
    })

    vim.keymap.set('n', '<leasder>ns', neotest.summary.toggle, {
      desc = '[N]eotest [S]ummary',
    })
  end,
}
