local lspconfig = require('lspconfig')

local format_augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_formatting = function()
  ignored_clients = {
    gopls = true, -- gofumpt via null-ls.
    tsserver = true, -- prettier via null-ls.
    volar = true, -- prettier via null-ls.
  }

  vim.lsp.buf.format({
    filter = function(client)
      return ignored_clients[client.name] == nil
    end,
  })
end

local on_attach = function(client, bufnr)
  require('lsp_signature').on_attach()

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
  km('n', 'gi', vim.lsp.buf.implementation)
  km('i', '<C-k>', vim.lsp.buf.signature_help)
  km('n', '<leader>D', vim.lsp.buf.type_definition)
  km('n', '<leader>rn', vim.lsp.buf.rename)
  km('n', 'gr', vim.lsp.buf.references)
  km('n', '<leader>ca', vim.lsp.buf.code_action)
  km('n', '<leader>e', vim.diagnostic.open_float)
  km('n', '[d', vim.diagnostic.goto_prev)
  km('n', ']d', vim.diagnostic.goto_next)
  km('n', '<leader>q', vim.diagnostic.setloclist)
  km('n', '<leader>wq', vim.diagnostic.setqflist)
  km('n', '<leader>so', require('telescope.builtin').lsp_document_symbols)
  km('n', '<leader>wso', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = false }) end, {})
end

local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.shellcheck,

    null_ls.builtins.diagnostics.shellcheck,

    null_ls.builtins.formatting.gofumpt.with({ extra_args = { '-extra' } }),
    null_ls.builtins.formatting.prettier,
  },
  on_attach = on_attach,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
  gopls = {
    gopls = {
      staticcheck = true,
      analyses = {
        unusedwrite = true,
      },
    },
  },
  eslint = {},
  volar = {},
  tsserver = {},
  pylsp = {},
}

for lsp, settings in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
  }
end
