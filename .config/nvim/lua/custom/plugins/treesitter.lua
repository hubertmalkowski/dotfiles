return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    branch = 'main', -- or "master", or any branch name

    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'query', 'vim', 'vimdoc' },
      auto_install = true,
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)

      -- new main branch dropped highlight/indent modules; enable via built-in
      local disabled_ft = { markdown = true }
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          if not disabled_ft[vim.bo[ev.buf].filetype] then
            pcall(vim.treesitter.start, ev.buf)
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      mode = 'cursor',
    },
  },

  {
    'romus204/tree-sitter-manager.nvim',
    config = function()
      require('tree-sitter-manager').setup {
        ensure_installed = {
          'haskell',
        },
        auto_install = true,
        languages = {
          haskell = {
            install_info = {
              revision = '98aedbd2d6947a168ba3ba3755d70b0cb6b78395',
              url = 'https://github.com/tree-sitter-grammars/tree-sitter-haskell',
            },
          },
        },
      }
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
