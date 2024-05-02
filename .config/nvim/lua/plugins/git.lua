return {
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },

    init = function()
      vim.g.fugitive_legacy_commands = 0
    end,
  },
}
