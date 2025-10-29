-- lua/custom_lualine/script_scrollbar.lua
local M = {}

local api = vim.api

-- SBAR characters from the provided script.
-- These characters might require a Nerd Font or a font with good Unicode coverage
-- for "Symbols for Legacy Computing" to render correctly.
-- Order: "more full" / "top" at the start, "less full" / "empty" at the end.
local DEFAULT_SBAR_CHARS = {
  '▔', -- U+2594 UPPER ONE EIGHTH BLOCK
  '🮂', -- U+1FB82 BOX DRAWINGS LIGHT DIAGONAL UPPER CENTRE TO MIDDLE LEFT AND MIDDLE RIGHT TO LOWER CENTRE
  '🬂', -- U+1FB82 (likely same as above or similar, from original script)
  '🮃', -- U+1FB83 BOX DRAWINGS LIGHT DIAGONAL MIDDLE CENTRE TO MIDDLE LEFT AND MIDDLE RIGHT TO LOWER CENTRE
  '▀', -- U+2580 UPPER HALF BLOCK
  '▄', -- U+2584 LOWER HALF BLOCK
  '▃', -- U+2583 LOWER THREE EIGHTHS BLOCK
  '🬭', -- U+1FBAD BOX DRAWINGS LIGHT DIAGONAL MIDDLE LEFT TO LOWER CENTRE AND MIDDLE RIGHT TO UPPER CENTRE
  '▂', -- U+2582 LOWER ONE EIGHTH BLOCK
  ' ', -- U+0020 SPACE (empty)
}

-- Alternative SBAR with more common block characters if the above don't render well:
-- Shows a bar that "empties" from top to bottom as you scroll down.
-- local ALTERNATIVE_SBAR_CHARS = {
--   "█", "▇", "▆", "▅", "▄", "▃", "▂", " ", " ", " "
-- }

local defaults = {
  sbar_chars = DEFAULT_SBAR_CHARS,
  repeat_char = 2, -- How many times to repeat the selected character (like in the script)
}

M.script_scrollbar = function(options)
  options = vim.tbl_deep_extend('force', {}, defaults, options or {})

  local current_buf = api.nvim_get_current_buf()

  -- Only show for normal, listed buffers
  if not api.nvim_buf_is_valid(current_buf) or vim.bo[current_buf].buftype ~= '' or not vim.bo[current_buf].buflisted then
    return ''
  end

  local cursor_line = api.nvim_win_get_cursor(0)[1] -- Current cursor line (1-indexed)
  local total_lines = api.nvim_buf_line_count(current_buf)

  if total_lines == 0 then
    -- Return the "empty" state character repeated
    local empty_char = options.sbar_chars[#options.sbar_chars] or ' '
    return string.rep(empty_char, options.repeat_char)
  end

  -- Calculate progress ratio: 0.0 at first line, approaches 1.0 at last line.
  -- (cursor_line - 1) ensures that for the first line, the numerator is 0.
  local progress_ratio = (cursor_line - 1) / total_lines

  -- Map the ratio to an index in the sbar_chars array.
  -- math.floor(progress_ratio * N) gives values from 0 to N-1. Add 1 for 1-based Lua index.
  local idx = math.floor(progress_ratio * #options.sbar_chars) + 1

  -- Clamp index to be safe, though the logic above should keep it in [1, #sbar_chars]
  idx = math.max(1, math.min(idx, #options.sbar_chars))

  local char_to_display = options.sbar_chars[idx] or ' '

  return string.rep(char_to_display, options.repeat_char)
end

return M
