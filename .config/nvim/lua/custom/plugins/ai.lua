return {
  { 'boltlessengineer/zeta.nvim' },
  {
    'zbirenbaum/copilot.lua',
    event = 'BufEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = false,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<M-Space>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    enabled = false,
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',

      'j-hui/fidget.nvim',
    },
    event = 'BufEnter',
    opts = {
      strategies = {
        chat = {
          adapter = 'gemini',
        },
        inline = {
          adapter = 'gemini',
        },
      },
      adapters = {
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            schema = {
              model = {
                default = 'gemini-2.5-flash-preview-04-17',
              },
            },
            env = {
              api_key = 'cmd:rbw get gemini',
            },
          })
        end,
      },
      display = {
        diff = {
          provider = 'mini_diff',
        },
      },
      prompt_library = {
        ['Diff code review'] = {
          strategy = 'chat',
          description = 'Perform a code review',
          opts = {
            auto_submit = true,
            user_prompt = false,
          },
          prompts = {
            {
              role = 'user',
              content = function()
                local target_branch = vim.fn.input('Target branch for merge base diff (default: master): ', 'master')

                return string.format(
                  [[You are a senior software engineer performing a code review. Analyze the following code changes.\n\n]
                   Identify any potential bugs, performance issues, security vulnerabilities, or areas that could be refactored for better readability or maintainability.\n
                   Explain your reasoning clearly and provide specific suggestions for improvement.\n
                   Consider edge cases, error handling, and adherence to best practices and coding standards.\n\n
                   Here are the code changes:\n\n
                   ```
                    %s
                   ```
                   ]],
                  vim.fn.system('git diff --merge-base ' .. target_branch)
                )
              end,
            },
          },
        },
      },
    },
    keys = {
      {
        '<leader>aa',
        '<cmd>CodeCompanionActions<CR>',
        desc = 'ai',
      },
      {
        '<leader>ac',
        '<cmd>CodeCompanionChat toggle<CR>',
        desc = 'chat',
      },
      {
        '<leader>ac',
        '<cmd> CodeCompanionChat Add<CR>',
        desc = 'chat about this',
        mode = 'v',
      },
      {
        '<leader>ac',
        '<cmd> CodeCompanionChat Add<CR>',
        desc = 'chat about this',
        mode = 'v',
      },

      {
        '<leader>ai',
        '<cmd> CodeCompanion<CR>',
        desc = 'inline assistant',
        mode = 'v',
      },
    },
  },
}
