local finder = function()
  if 1 == vim.fn.executable('fd') then
    return {
      'fd',
      '--hidden', '--no-ignore-vcs', '--strip-cwd-prefix',
      '--type', 'f',
      '--color', 'never',
      '--exclude', '.git/',
      '--exclude', 'node_modules/',
    }
  elseif 1 == vim.fn.executable('rg') then
    return {
      'rg',
      '--hidden', '--no-ignore-vcs', '--files',
      '--color', 'never',
      '--glob', '!.git/',
      '--glob', '!node_modules/',
    }
  elseif 1 == vim.fn.executable('find') and vim.fn.has('win32') == 0 then
    return {
      'find', '.',
      '-type', 'f',
      '-not', '-path', '*.git/*',
      '-not', '-path', '*node_modules/*',
    }
  end
end

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-c>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = finder(),
    },
    buffers = {
      mappings = {
        n = {
          ['D'] = 'delete_buffer',
        },
      },
    },
  },
})

-- This will load fzy_native and have it override the default file sorter
require('telescope').load_extension('zf-native')
