-- Task managers and stuff like that
return {
  'Hashino/doing.nvim',
  opts = {
    store = {
      file_name = '.tasks', -- name of tasks file
      sync_tasks = true, -- keeps the file tasks always in sync with the tasks
    },
    winbar = { enabled = false },
  },
  keys = {
    {
      '<leader>tt',
      function()
        local doing = require 'doing'
        doing.edit()
      end,
      {
        desc = '[T]oggle [T]asks',
      },
    },
  },
}
