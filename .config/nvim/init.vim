call plug#begin(stdpath('data') . '/plugged')
  Plug 'L3MON4D3/LuaSnip'
  Plug 'axelf4/vim-strip-trailing-whitespace'
  Plug 'cormacrelf/vim-colors-github'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-calc'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'kdheepak/cmp-latex-symbols'
  Plug 'lervag/vimtex'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'tjdevries/train.nvim'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tversteeg/registers.nvim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'windwp/nvim-autopairs'
call plug#end()

lua <<EOF
  require('plugin.lsp')
  require('plugin.treesitter')
  require('plugin.telescope-config')
  require('plugin.completion')
  require('plugin.autopairs')
EOF
