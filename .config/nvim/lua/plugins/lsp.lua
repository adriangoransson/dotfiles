return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'ray-x/lsp_signature.nvim',
      { 'j-hui/fidget.nvim', config = true },
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
          { 'williamboman/mason.nvim', config = true },
        },

        opts = {
          automatic_installation = true,
        },
      },
    },

    config = function()
      local lspconfig = require('lspconfig')

      local format_augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local lsp_formatting = function()
        local ignored_clients = {
          gopls = true,    -- gofumpt via null-ls.
          tsserver = true, -- prettier via null-ls.
          volar = true,    -- prettier via null-ls.
        }

        vim.lsp.buf.format({
          filter = function(client)
            return ignored_clients[client.name] == nil
          end,
        })
      end

      local on_attach = function(client, bufnr)
        require('lsp_signature').on_attach({ hint_enable = false }, bufnr)

        -- TODO: check if telescope is available first.
        local telescope = require('telescope.builtin')

        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = format_augroup,
            buffer = bufnr,
            callback = lsp_formatting,
          })
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }
        local km = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        km('n', 'gD', vim.lsp.buf.declaration)
        km('n', 'gd', vim.lsp.buf.definition)
        km('n', 'K', vim.lsp.buf.hover)
        km('n', 'gi', telescope.lsp_implementations)
        km('i', '<C-k>', vim.lsp.buf.signature_help)
        km('n', '<leader>D', vim.lsp.buf.type_definition)
        km('n', '<leader>rn', vim.lsp.buf.rename)
        km('n', 'gr', telescope.lsp_references)
        km({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
        km('n', '<leader>e', vim.diagnostic.open_float)
        km('n', '[d', vim.diagnostic.goto_prev)
        km('n', ']d', vim.diagnostic.goto_next)
        km('n', '<leader>q', vim.diagnostic.setloclist)
        km('n', '<leader>wq', vim.diagnostic.setqflist)
        km('n', '<leader>so', telescope.lsp_document_symbols)
        km('n', '<leader>wso', telescope.lsp_dynamic_workspace_symbols)

        vim.api.nvim_create_user_command('Format', function()
          vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
        end, {})
      end

      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          -- redundancy :(
          null_ls.builtins.formatting.golines.with({ extra_args = { '--base-formatter=gofumpt' } }), -- Slow with default formatter! :(
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.gofumpt.with({ extra_args = { '-extra' } }),

          null_ls.builtins.formatting.prettier,
        },
        on_attach = on_attach,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local servers = {
        gopls = {
          gopls = {
            staticcheck = true,
            analyses = {
              unusedwrite = true,
              composites = false,
            },
          },
        },
        bashls = {},
        clangd = {},
        eslint = {},
        volar = {},
        tsserver = {},
        pylsp = {},
        html = {},
        cssls = {},
        lua_ls = {
          Lua = {
            -- From https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            runtime = { version = 'LuaJIT' },
            -- Get the language server to recognize the `vim` global
            diagnostics = { globals = { 'vim' } },
            -- Make the server aware of Neovim runtime files
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },

            -- Trailing commas.
            format = {
              defaultConfig = {
                quote_style = 'single',
                trailing_table_separator = 'smart',
              },
            },
          },
        },
        svelte = {},
      }

      for lsp, settings in pairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = settings,
        })
      end
    end,
  },

}
