return {
  {
    'tpope/vim-fugitive',
    enabled = false,
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.G, {
        desc = '[G]it [S]tatus',
      })
      vim.keymap.set('n', '<leader>gc', function()
        vim.cmd.G 'commit'
      end, {
        desc = '[G]it [C]ommit',
      })
    end,
  },
  {
    'f-person/git-blame.nvim',
    -- load the plugin at startup
    event = 'VeryLazy',
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = '<author> - <summary>', -- template for the blame message, check the Message template section for more options
      date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      delay = 1000,
      message_when_not_committed = '',
    },
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "echasnovski/mini.pick",         -- optional
    },
    config = true,
    opts = {
      kind = 'floating',
      graph_style = 'kitty',
    },
    keys = {
      {
        '<leader>gs',
        function()
          require('neogit').open()
        end,
        desc = '[G]it [S]tatus',
      },

      {
        '<leader>gc',
        function()
          require('neogit').open { 'commit c' }
        end,
        desc = '[G]it [C]ommit',
      },
    },
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
