call plug#begin(stdpath('data') . '/plugged')
  Plug 'AckslD/nvim-trevJ.lua'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'axelf4/vim-strip-trailing-whitespace'
  Plug 'catppuccin/nvim', {'as': 'catppuccin'}
  Plug 'cormacrelf/vim-colors-github'
  Plug 'habamax/vim-asciidoctor'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-calc'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'jghauser/mkdir.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'levouh/tint.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'nvim-treesitter/playground'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'smjonas/live-command.nvim'
  Plug 'stevearc/dressing.nvim'
  Plug 'tjdevries/train.nvim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tversteeg/registers.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'windwp/nvim-autopairs'
call plug#end()

lua <<EOF
  -- Manually init plugins.
  require('registers').setup()
  require('live-command').setup({
    commands = {
      GG = { cmd = 'g' }, -- fugitive maps G.
      Norm = { cmd = 'norm' },
    },
  })

  -- Custom configuration.
  require('plugin.mason')
  require('plugin.lsp')
  require('plugin.treesitter')
  require('plugin.telescope-config')
  require('plugin.completion')
EOF
