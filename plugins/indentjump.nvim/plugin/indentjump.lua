local function reverse_list(arr)
  local i, j = 1, #arr
  while i < j do
    arr[i], arr[j] = arr[j], arr[i]
    i = i + 1
    j = j - 1
  end
end

local function is_empty_line(line)
  return line:gsub("%s+", "") == ""
end

local function get_indent(line)
  return string.len(line) - string.len(line:match'^%s*(.*)')
end

local function get_next_nonempty_line_index(lines)
  local ret = 1

  for index, line in pairs(lines) do
    ret = index
    if not is_empty_line(line) then
      break
    end
  end

  return ret
end

local function get_next_block_index(lines)
  if is_empty_line(lines[1]) then
    return get_next_nonempty_line_index(lines)
  end

  local target_indent = get_indent(lines[1])
  local changed = false
  for index, line in pairs(lines) do
    if is_empty_line(line) then
      changed = true
    else
      local indent = get_indent(line)
      if indent < target_indent then
        return index
      elseif indent == target_indent then
        if changed then
          return index
        end
      else
        changed = true
      end
    end
  end

  return #lines
end

local function indent_jump_down()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local r = cursor[1]
  local c = cursor[2]
  local below_lines = vim.api.nvim_buf_get_lines(0, r - 1, -1, false)
  local relative_next_block_index = get_next_block_index(below_lines)
  local next_block_index = r + relative_next_block_index
  vim.api.nvim_win_set_cursor(0, { next_block_index - 1, c })
end

local function indent_jump_up()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local r = cursor[1]
  local c = cursor[2]
  local above_lines = vim.api.nvim_buf_get_lines(0, 0, r, false)
  reverse_list(above_lines)
  local relative_next_block_index = get_next_block_index(above_lines)
  local next_block_index = r - relative_next_block_index
  vim.api.nvim_win_set_cursor(0, { next_block_index + 1, c })
end

vim.api.nvim_create_user_command('IndentJumpDown', indent_jump_down, {})
vim.api.nvim_create_user_command('IndentJumpUp', indent_jump_up, {})
