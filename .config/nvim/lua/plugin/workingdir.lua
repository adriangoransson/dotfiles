-- This plugin returns the current working directory relative from the home
-- directory. If the working directory is not a child of the home directory, an
-- absoulute path is returned. If the working directory is deeper than <depth>
-- levels from the home directory, it is truncated.

local M = {}

local modify = vim.fn.fnamemodify

M.get = function(depth)
  local dir = modify(vim.fn.getcwd(), ':~')

  if string.sub(dir, 1, 1) ~= '~' then
    return dir
  end

  local modifier = string.rep(':h', depth)
  local parent = modify(dir, modifier)
  if parent == '.' then
    -- nothing to truncate.
    return dir
  end

  -- Return the current directory
  -- -> starting at length of parent (+1 because 1-indexing)
  -- -> with leading '/' removed if it exists.
  return dir:sub(#parent + 1):gsub('^/', '')
end

return M
