return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  enabled = false,
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        -- Accept on alt + space
        accept = '<C-Space>',
      },
    },
  },
  keymap = {
    '<leader>tc',
    function()
      require('copilot.suggestion').toggle_auto_trigger()
    end,
    desc = '[T]oggle [C]opilot',
  },
}
