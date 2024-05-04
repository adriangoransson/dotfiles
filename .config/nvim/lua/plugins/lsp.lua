return {
	{
		"ray-x/lsp_signature.nvim",
		opts = { hint_enable = false },
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = { automatic_installation = true },
			},
			{
				"folke/neodev.nvim",
				opts = {},
			},
		},

		config = function()
			local lspconfig = require("lspconfig")

			local on_attach = function(_, bufnr)
				-- TODO: check if telescope is available first.
				local telescope = require("telescope.builtin")

				local opts = { noremap = true, silent = true, buffer = bufnr }
				local map = function(mode, lhs, rhs)
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				map("n", "gD", vim.lsp.buf.declaration)
				map("n", "gd", vim.lsp.buf.definition)
				map("n", "K", vim.lsp.buf.hover)
				map("n", "gi", telescope.lsp_implementations)
				map("i", "<C-k>", vim.lsp.buf.signature_help)
				map("n", "<leader>D", vim.lsp.buf.type_definition)
				map("n", "<leader>rn", vim.lsp.buf.rename)
				map("n", "gr", telescope.lsp_references)
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
				map("n", "<leader>e", vim.diagnostic.open_float)
				map("n", "[d", vim.diagnostic.goto_prev)
				map("n", "]d", vim.diagnostic.goto_next)
				map("n", "<leader>q", vim.diagnostic.setloclist)
				map("n", "<leader>wq", vim.diagnostic.setqflist)
				map("n", "<leader>so", telescope.lsp_document_symbols)
				map("n", "<leader>wso", telescope.lsp_dynamic_workspace_symbols)
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
						runtime = { version = "LuaJIT" },
						-- Get the language server to recognize the `vim` global
						diagnostics = { globals = { "vim" } },
						-- Make the server aware of Neovim runtime files
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = { enable = false },

						-- Trailing commas.
						format = {
							defaultConfig = {
								quote_style = "single",
								trailing_table_separator = "smart",
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
