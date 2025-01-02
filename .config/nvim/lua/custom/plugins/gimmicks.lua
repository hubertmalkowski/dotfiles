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
      -- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
      vim.keymap.set('n', '<leader>cr', '<cmd>Lspsaga rename<CR>', {
        desc = '[R]ename',
      })
      vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = '[C]ode [A]ctions' })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional 'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  -- {
  --   'lewis6991/hover.nvim',
  --   event = 'LspAttach',
  --   opts = {
  --     init = function()
  --       require 'hover.providers.lsp'
  --     end,
  --     preview_opts = {
  --       border = 'single',
  --     },
  --     -- Whether the contents of a currently open hover window should be moved
  --     -- to a :h preview-window when pressing the hover keymap.
  --     preview_window = false,
  --     title = true,
  --     mouse_providers = {
  --       'LSP',
  --     },
  --     mouse_delay = 1000,
  --   },
  --   keys = {
  --     {
  --       'n',
  --       'K',
  --       function()
  --         require('hover').hover()
  --       end,
  --     },
  --   },
  -- },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        mode = 'cursor',
      }
    end,
  },

  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   opts = {},
  --   enable = false,
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
