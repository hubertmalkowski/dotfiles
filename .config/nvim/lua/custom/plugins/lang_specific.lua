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
    opts = {
      code = {
        language = false,
      },
    },
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
  -- Coq/Roq
  {
    'whonore/Coqtail',
    init = function()
      -- only want Coqtail's ftdetect/syntax; vsrocq.nvim drives the proofs.
      -- skipping plugin/coqtail.vim means we must define coqtail_supported
      -- ourselves, else ftplugin/coq.vim errors out and kills the FileType chain
      vim.g.loaded_coqtail = 1
      vim.g.coqtail_supported = 0
    end,
  },
  {
    'tomtomjhj/vsrocq.nvim',
    ft = { 'coq' },
    dependecies = {
      'whonore/Coqtail',
    },
    opts = {
      -- vsrocq = { ... }
      -- lsp = { ... }
    },
    keys = {
      {
        '<leader>rf',
        '<cmd>VsRocq stepForward<CR>',
        desc = '(r)ocq  step(F)orward',
      },
      {
        '<leader>rb',
        '<cmd>VsRocq stepBackward<CR>',
        desc = '(r)ocq  step(B)ackward',
      },

      {
        '<leader>rp',
        '<cmd>VsRocq interpretToPoint<CR>',
        desc = '(r)ocq  interpreTo(p)oint',
      },
    },
  },

  {
    'koka-lang/koka',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. 'support/vim')
    end,
  },
}
