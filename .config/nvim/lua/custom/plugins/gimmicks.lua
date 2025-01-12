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
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        mode = 'cursor',
      }
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      local ftMap = {
        vue = { 'treesitter', 'ident' },
      }
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require 'ufo'

      ufo.setup {
        open_fold_hl_timeout = 150,
        provider_selector = function(bufnr, filetype, buftype)
          return ftMap[filetype]
        end,
        close_fold_kinds_for_ft = {
          default = { 'imports', 'comment' },
        },
        enable_get_fold_virt_text = false,
      }

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
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
