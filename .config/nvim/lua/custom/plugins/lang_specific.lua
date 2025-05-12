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
          group = '(R)ails',
        },
      }
    end,
    keys = {
      {
        '<leader>rm',
        '<cmd>Emodel<CR>',
        desc = '(R)ails (M)odel',
      },
      {
        '<leader>rc',
        '<cmd>Econtroller<CR>',
        desc = '(R)ails (C)ontroller',
      },
      {
        '<leader>rv',
        '<cmd>Eview<CR>',
        desc = '(R)ails (V)iew',
      },
    },
  },

  --markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ft = { 'markdown', 'codecompanion' },
    ---@module 'render-marthink we need the Ringkdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- Angular
  {
    'joeveiga/ng.nvim',
    ft = { 'typescript', 'html', 'css', 'scss' },
    keys = {
      {
        '<leader>lat',
        function()
          require('ng').goto_template_for_component {}
        end,
        desc = '(A)ngular (T)emplate',
      },
      {
        '<leader>lac',
        function()
          require('ng').goto_component_with_template_file {}
        end,
        desc = '(A)ngular (C)omponent',
      },
    },
  },
}
