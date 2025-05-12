return {
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
    enabled = false,
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
