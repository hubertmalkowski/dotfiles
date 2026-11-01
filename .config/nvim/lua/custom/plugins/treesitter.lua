return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    branch = 'main', -- or "master", or any branch name

    config = function()
      local ts = require 'nvim-treesitter'
      ts.setup {}

      -- parsers not in the nvim-treesitter registry, add them by hand
      local custom_parsers = {
        -- Rocq (formerly Coq)
        rocq = {
          url = 'https://github.com/aruzdh/tree-sitter-rocq',
          revision = '300fe33fc299c30f736fd56d8ef8a28b08acd4e6',
        },
        koka = {
          url = 'https://github.com/koka-community/tree-sitter-koka',
          revision = '07b1ce29a06656b552f7f198e572499062ccfffe',
        },
        flix = {
          url = 'https://github.com/wstein/tree-sitter-flix',
          revision = '349e4d3d23c71bd13e4e414b708714e5ca3c78b2',
        },
      }
      local function register_custom_parsers()
        local parsers = require 'nvim-treesitter.parsers'
        for lang, info in pairs(custom_parsers) do
          parsers[lang] = {
            install_info = vim.tbl_extend('force', { queries = 'queries' }, info),
            tier = 0,
          }
        end
      end
      vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', callback = register_custom_parsers })
      pcall(register_custom_parsers)

      -- `.v` files are filetype `coq` (Coqtail/vsrocq expect that), parser is `rocq`
      vim.treesitter.language.register('rocq', 'coq')

      -- main branch dropped ensure_installed/auto_install, do it by hand
      local ensure_installed =
        { 'bash', 'c', 'diff', 'flix', 'haskell', 'html', 'lua', 'koka', 'luadoc', 'query', 'rocq', 'scala', 'vim', 'vimdoc' }
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
