return {
  -- {
  --   'copilotlsp-nvim/copilot-lsp',
  -- },
  -- {
  --   'copilotlsp-nvim/copilot-lsp',
  --   init = function()
  --     vim.g.copilot_nes_debounce = 500
  --     vim.lsp.enable 'copilot_ls'
  --     vim.keymap.set('n', '<tab>', function()
  --       local bufnr = vim.api.nvim_get_current_buf()
  --       local state = vim.b[bufnr].nes_state
  --       if state then
  --         -- Try to jump to the start of the suggestion edit.
  --         -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
  --         local _ = require('copilot-lsp.nes').walk_cursor_start_edit()
  --           or (require('copilot-lsp.nes').apply_pending_nes() and require('copilot-lsp.nes').walk_cursor_end_edit())
  --         return nil
  --       else
  --         -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
  --         return '<C-i>'
  --       end
  --     end, { desc = 'Accept Copilot NES suggestion', expr = true })
  --   end,
  -- },
  {
    'zbirenbaum/copilot.lua',
    requires = {
      'copilotlsp-nvim/copilot-lsp',
      init = function()
        vim.g.copilot_nes_debounce = 500
      end,
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        nes = {
          enabled = false,
          keymap = {
            accept_and_goto = '<C-p>',
            accept = false,
            dismiss = '<Esc>',
          },
        },
      }
    end,
  },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   enabled = false,
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
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
        http = {
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              schema = {
                model = {
                  default = 'gemini-2.5-flash-preview-05-20',
                },
              },
              env = {
                api_key = 'cmd:rbw get gemini',
              },
            })
          end,
          gemini_pro = function()
            return require('codecompanion.adapters').extend('gemini', {
              schema = {
                model = {
                  default = 'gemini-2.5-pro-preview-05-06',
                },
              },
              env = {
                api_key = 'cmd:rbw get gemini',
              },
            })
          end,
        },
        acp = {
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = 'cmd:rbw get AnthropicKey',
              },
            })
          end,
        },
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
                  [[
                  You are a senior software engineer performing a code review. Analyze the following code changes.
                   Identify any potential bugs, performance issues, security vulnerabilities, or areas that could be refactored for better readability or maintainability.
                   Explain your reasoning clearly and provide specific suggestions for improvement.
                   Consider edge cases, error handling, and adherence to best practices and coding standards.
                   Here are the code changes:
                   ```
                    %s
                   ```
                   ]],
                  vim.fn.system('git diff --merge-base ' .. target_branch .. " -- . ':!**/pnpm-lock.yaml'")
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
    init = function()
      require('custom.components.codecompanion_spinner'):init()
    end,
  },
}
