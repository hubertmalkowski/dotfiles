return {
  'zk-org/zk-nvim',
  -- keys = {
  --   { '<leader>zn', '<cmd>ZkNotes<cr>', desc = '(z)k notes' },
  --   { '<leader>zb', '<cmd>ZkBacklinks<cr>', desc = '(z)k backlinks' },
  -- },
  config = function()
    require('zk').setup {
      picker_options = {
        snacks_picker = {
          layout = {
            preset = 'ivy',
          },
        },
      },
    }
  end,
}
