return {
  'folke/snacks.nvim',
  opts = {
    input = {},
    picker = {},
    lazygit = {
      wo = {
        winhighlight = 'NormalFloat:Transparent',
      },
    },
    zen = {
      toggles = {
        dim = false,
        git_signs = false,
        mini_diff_signs = false,
      },
      win = {
        style = {
          enter = true,
          fixbuf = false,
          minimal = false,
          width = 120,
          height = 0,
          backdrop = { transparent = false, blend = 0, bg = '#080808' },
          keys = { q = false },
          zindex = 40,
          wo = {
            winhighlight = 'NormalFloat:Normal',
          },
        },
        -- style = 'dashboard',
      },
    },
  },
  keys = {
    {
      '<leader>gl',
      function()
        require('snacks').lazygit()
      end,
      desc = '[G]it [L]azy',
    },
    {
      '<leader>tz',
      function()
        require('snacks').zen()
      end,
      desc = '[T]oggle [Z]en',
    },

    -- Fuzzy
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.git_files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch [G]rep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols {
          layout = 'vscode',
          sort = {
            -- default sort is by score, text length and index
            fields = { 'score:desc', 'idx:desc' },
          },
        }
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.commands {
          layout = 'vscode',
        }
      end,
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Search Lines',
    },
  },
}
