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
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup()

      -- don't let vim-sleuth pick up tabs from badly formatted files
      vim.g.sleuth_java_heuristics = 0

      -- format like checkstyle wants (see java/eclipse-formatter.xml)
      vim.lsp.config('jdtls', {
        settings = {
          java = {
            format = {
              enabled = true,
              settings = {
                url = vim.fn.stdpath 'config' .. '/java/eclipse-formatter.xml',
                profile = 'Checkstyle',
              },
            },
            -- CustomImportOrder: third party, then java/javax, then static
            completion = { importOrder = { '', 'java', 'javax', '#' } },
            -- AvoidStarImport
            sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
          },
        },
      })
      vim.lsp.enable 'jdtls'
    end,
  },

  -- Flix (needs java 21+ and flix.jar in project root)
  {
    'flix/nvim',
    ft = 'flix',
    init = function()
      -- plugin registers the filetype in plugin/flix.lua, which lazy-loading
      -- skips, so ft = 'flix' would never trigger without this
      vim.filetype.add { extension = { flix = 'flix' } }
    end,
    config = function()
      require('flix').setup()
      vim.lsp.enable 'flix'
    end,
    keys = {
      {
        '<leader>lfr',
        function()
          require('flix.commands').flix_cmd 'run'
        end,
        desc = '(F)lix (R)un',
        ft = 'flix',
      },
      {
        '<leader>lft',
        function()
          require('flix.commands').flix_cmd 'test'
        end,
        desc = '(F)lix (T)est',
        ft = 'flix',
      },
    },
  },

  -- Scala
  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
    -- no 'java' here, jdtls owns those buffers
    ft = { 'scala', 'sbt' },
    opts = function()
      local metals_config = require('metals').bare_config()
      metals_config.settings = {
        showImplicitArguments = true,
        showInferredType = true,
        excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      }
      metals_config.init_options.statusBarProvider = 'off'
      metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()
      metals_config.on_attach = function()
        require('metals').setup_dap()
      end
      return metals_config
    end,
    config = function(self, metals_config)
      local group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = group,
      })
    end,
    keys = {
      {
        '<leader>lsc',
        function()
          require('metals').commands()
        end,
        desc = '(S)cala Metals (C)ommands',
        ft = { 'scala', 'sbt' },
      },
      {
        '<leader>lsw',
        function()
          require('metals').hover_worksheet()
        end,
        desc = '(S)cala (W)orksheet hover',
        ft = { 'scala', 'sbt' },
      },
    },
  },
}
