require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',

  ignore_install = { 'phpdoc', 'vala' },

  highlight = {
    enable = true,
  },
})

require('treesitter-context').setup({
  patterns = {
    default = {
          'class',
          'function',
          'method',
      },
  },
})
