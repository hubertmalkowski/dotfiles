-- lua/custom_lualine/scrollbar.lua

local M = {}

-- Default options
local defaults = {
  width = 10, -- Total width of the scrollbar in characters
  thumb_char = '█', -- Character for the scrollbar thumb
  track_char = '░', -- Character for the scrollbar track
  -- For a more "classic" look, you could use:
  -- thumb_char = "▋",
  -- track_char = " ",
}

M.scrollbar = function(options)
  options = vim.tbl_deep_extend('force', {}, defaults, options or {})

  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)

  -- Check if the buffer is valid and listed
  if not vim.api.nvim_buf_is_valid(current_buf) or vim.bo[current_buf].buftype ~= '' or not vim.bo[current_buf].buflisted then
    return '' -- Don't show for non-normal buffers
  end

  local total_lines = vim.api.nvim_buf_line_count(current_buf)
  local win_height = vim.fn.winheight(0) -- Height of the current window
  local top_line = vim.fn.line 'w0' -- First visible line in the window (1-indexed)

  -- If the entire buffer fits in the window, or no lines, or invalid window height
  if total_lines <= 0 or win_height <= 0 or total_lines <= win_height then
    -- Show a full thumb or empty if preferred
    -- For this example, let's show a full thumb if there's content
    if total_lines > 0 then
      return string.rep(options.thumb_char, options.width)
    else
      return string.rep(options.track_char, options.width)
    end
  end

  -- Calculate thumb size
  -- Thumb size is proportional to the visible part of the buffer
  local thumb_ratio = win_height / total_lines
  local thumb_size = math.max(1, math.floor(options.width * thumb_ratio))

  -- Calculate thumb position
  -- scrollable_range is the number of lines that can be scrolled past
  local scrollable_range = total_lines - win_height
  -- current_scroll_pos is how many lines we've scrolled from the top (0-indexed)
  local current_scroll_pos = top_line - 1
  -- scroll_progress is a value from 0 (top) to 1 (bottom)
  local scroll_progress = current_scroll_pos / scrollable_range

  -- track_space_for_thumb is the space within the scrollbar where the thumb can move
  local track_space_for_thumb = options.width - thumb_size
  local thumb_offset = math.floor(scroll_progress * track_space_for_thumb)

  -- Ensure thumb_offset is within bounds (it should be, but defensive check)
  thumb_offset = math.max(0, math.min(thumb_offset, options.width - thumb_size))

  -- Build the scrollbar string
  local sbar = {}
  for i = 1, options.width do
    if i > thumb_offset and i <= thumb_offset + thumb_size then
      table.insert(sbar, options.thumb_char)
    else
      table.insert(sbar, options.track_char)
    end
  end

  return table.concat(sbar)
end

-- You can also provide a more convenient way to call it if you want
-- e.g., M.get_scrollbar = function() return M.scrollbar() end

return M
