vim.api.nvim_create_user_command('Qq', function(opts)
  local current_bufnr = vim.api.nvim_get_current_buf()
  local force_char = opts.bang and '!' or '' -- Add "!" if :BdeleteOthers! is used

  local buffers_to_delete = {}
  -- Get all listed buffers
  for _, buf_info in ipairs(vim.fn.getbufinfo { buflisted = true }) do
    if buf_info.bufnr ~= current_bufnr then
      table.insert(buffers_to_delete, buf_info.bufnr)
    end
  end

  if #buffers_to_delete == 0 then
    vim.notify('No other listed buffers to delete.', vim.log.levels.INFO)
    return
  end

  -- Construct the command string to delete specific buffers
  -- e.g., "bdelete! 1 2 5"
  local cmd = 'bdelete' .. force_char .. ' ' .. table.concat(buffers_to_delete, ' ')

  local ok, err = pcall(vim.cmd, cmd)
  if ok then
    vim.notify(string.format('Deleted %d other buffer(s).', #buffers_to_delete), vim.log.levels.INFO)
  else
    vim.notify('Error deleting buffers: ' .. tostring(err), vim.log.levels.ERROR)
  end

  -- Ensure the current buffer is still focused, just in case
  -- (though bdelete targeting specific numbers shouldn't change the current buffer)
  if vim.api.nvim_buf_is_valid(current_bufnr) then
    vim.api.nvim_set_current_buf(current_bufnr)
  end
end, {
  bang = true, -- Allows :BdeleteOthers!
  desc = 'Delete all listed buffers except the current one.',
})
