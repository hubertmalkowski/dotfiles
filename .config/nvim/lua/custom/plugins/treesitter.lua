return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    branch = 'main', -- or "master", or any branch name

    config = function()
      local ts = require 'nvim-treesitter'
      ts.setup {}

      -- Rocq (formerly Coq): not in the nvim-treesitter registry, add it by hand
      local function register_rocq()
        require('nvim-treesitter.parsers').rocq = {
          install_info = {
            url = 'https://github.com/aruzdh/tree-sitter-rocq',
            revision = '300fe33fc299c30f736fd56d8ef8a28b08acd4e6',
            queries = 'queries',
          },
          tier = 0,
        }
      end
      vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', callback = register_rocq })
      pcall(register_rocq)

      -- `.v` files are filetype `coq` (Coqtail/vsrocq expect that), parser is `rocq`
      vim.treesitter.language.register('rocq', 'coq')

      -- main branch dropped ensure_installed/auto_install, do it by hand
      local ensure_installed =
        { 'bash', 'c', 'diff', 'haskell', 'html', 'lua', 'luadoc', 'query', 'rocq', 'vim', 'vimdoc' }
      local installed = ts.get_installed 'parsers'
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, ensure_installed)
      if #missing > 0 then
        ts.install(missing)
      end

      -- main branch also dropped highlight/indent modules; enable via built-in
      local disabled_ft = { markdown = true }
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype
          if disabled_ft[ft] then
            return
          end
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end
          if vim.list_contains(ts.get_installed 'parsers', lang) then
            pcall(vim.treesitter.start, ev.buf)
          elseif vim.list_contains(ts.get_available(), lang) then
            ts.install(lang):await(function()
              pcall(vim.treesitter.start, ev.buf)
            end)
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
    -- conflicts with nvim-treesitter main: same install dir, overrides
    -- :TSInstall/:TSUpdate, and can't install parsers from a local path
    enabled = false,
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
