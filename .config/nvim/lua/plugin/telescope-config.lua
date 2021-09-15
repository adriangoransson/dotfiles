-- This will load fzy_native and have it override the default file sorter
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-c>"] = false
      }
    }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}

M.project_files = function()
  local picker = require('telescope.builtin')

  local ok = pcall(picker.git_files)
  if not ok then picker.find_files({ hidden = true, follow = true }) end
end

return M
