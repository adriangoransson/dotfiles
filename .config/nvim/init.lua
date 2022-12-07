require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'AckslD/nvim-trevJ.lua'
  use 'axelf4/vim-strip-trailing-whitespace'
  use 'habamax/vim-asciidoctor'
  use 'jghauser/mkdir.nvim'
  use 'tpope/vim-abolish'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'

  use {
    'levouh/tint.nvim',
    {
      'catppuccin/nvim',
      as = 'catppuccin',
    },
    {
      'cormacrelf/vim-colors-github',
      config = function()
        require('setup.color')
      end,
    },
  }

  use {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup({
        input = {
          -- When true, <Esc> will close the modal
          insert_only = false,
          win_options = {
            winblend = 0,
          },
        },
      })
    end,
  }

  use {
    'smjonas/live-command.nvim',
    config = function()
      require('live-command').setup({
        commands = {
          GG = { cmd = 'g' }, -- fugitive maps G.
          Norm = { cmd = 'norm' },
        },
      })
    end,
  }

  use {
    'tversteeg/registers.nvim',
    -- Bug in later version: https://github.com/tversteeg/registers.nvim/issues/74.
    tag = 'v1.5.0',
  }


  -- LSP
  use {
    {
      'williamboman/mason.nvim',
      config = function() require('mason').setup() end,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('mason-lspconfig').setup({
          automatic_installation = true,
        })
      end,
    },
    { 'j-hui/fidget.nvim', config = function() require('fidget').setup() end },
    'ray-x/lsp_signature.nvim',
    {
      'neovim/nvim-lspconfig',
      config = function() require('setup.lsp') end,
    },
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Treesitter
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = 'all',

          ignore_install = { 'phpdoc', 'vala' },

          highlight = {
            enable = true,
          },
        })
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup({
          patterns = {
            default = {
              'class',
              'function',
              'method',
            },
          },
        })
      end,
    },
    'nvim-treesitter/playground',
  }

  -- Telescope
  use {
    'natecraddock/telescope-zf-native.nvim',
    {
      'nvim-telescope/telescope.nvim',
      config = function() require('setup.telescope') end,
      requires = 'nvim-lua/plenary.nvim',
    },
  }

  -- Completion
  use {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'windwp/nvim-autopairs',

    {
      'hrsh7th/nvim-cmp',
      config = function()
        require('setup.completion')
      end,
    },
  }
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])
