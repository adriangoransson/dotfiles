return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
        globalstatus = true,
      },

      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = {
          { 'filename', path = 1 },
        },

        lualine_x = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },

      extensions = { 'fugitive', 'lazy', 'mason', 'quickfix' },
    },

    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
