call plug#begin(stdpath('data') . '/plugged')
  Plug 'cormacrelf/vim-colors-github'
  Plug 'lervag/vimtex'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'rstacruz/vim-closer'
  Plug 'tjdevries/train.nvim'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
call plug#end()
