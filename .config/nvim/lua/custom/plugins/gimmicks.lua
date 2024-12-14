return {
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup {
        symbol_in_winbar = { hide_keyword = true, enable = false, separator = ' |> ', folder_level = 0 },
        lightbulb = { virtual_text = false },
        ui = { code_action = '' },
      }
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
      vim.keymap.set('n', '<leader>cr', '<cmd>Lspsaga rename<CR>', {
        desc = '[R]ename',
      })
      vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = '[C]ode [A]ctions' })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional 'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        mode = 'topline',
      }
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
