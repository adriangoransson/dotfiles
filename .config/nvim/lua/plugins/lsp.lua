return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			{
				"williamboman/mason-lspconfig.nvim",

				dependencies = { "saghen/blink.cmp" },

				config = function()
					local c = require("mason-lspconfig")

					c.setup({
						ensure_installed = {
							"cssls",
							"gopls",
							"html",
							"lua_ls",
							"rust_analyzer",
							"svelte",
							"ts_ls",
						},
					})

					local setup_server = function(name, settings, capabilities)
						require("lspconfig")[name].setup({
							capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
							settings = settings,
						})
					end

					c.setup_handlers({
						-- First entry (without a key) is the default handler.
						function(server_name)
							setup_server(server_name, {})
						end,

						["gopls"] = function(name)
							setup_server(name, {
								gopls = {
									staticcheck = true,
									analyses = {
										unusedwrite = true,
										composites = false,
									},
									hints = {
										assignVariableTypes = true,
										compositeLiteralFields = true,
										compositeLiteralTypes = true,
										constantValues = true,
										parameterNames = true,
										rangeVariableTypes = true,
									},
								},
							})
						end,

						["lua_ls"] = function(name)
							setup_server(name, {
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
							})
						end,

						["rust_analyzer"] = function(name)
							setup_server(name, {
								["rust-analyzer"] = {
									check = {
										command = "clippy",
									},
								},
							})
						end,
					})
				end,
			},
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local implementations = vim.lsp.buf.implementation
					local references = vim.lsp.buf.references
					local document_symbols = vim.lsp.buf.document_symbol
					local workspace_symbols = vim.lsp.buf.workspace_symbol

					if Snacks ~= nil then
						implementations = Snacks.picker.lsp_implementations
						references = Snacks.picker.lsp_references
						document_symbols = Snacks.picker.lsp_symbols
						workspace_symbols = Snacks.picker.lsp_workspace_symbols
					end

					local opts = { noremap = true, silent = true, buffer = args.buf }
					local map = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, opts)
					end

					vim.api.nvim_create_user_command("InlayHintsToggle", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
					end, {})

					vim.lsp.inlay_hint.enable(true)

					map("n", "gD", vim.lsp.buf.declaration)
					map("n", "gd", vim.lsp.buf.definition)
					map("n", "K", vim.lsp.buf.hover)
					map("n", "gi", implementations)
					map("i", "<C-k>", vim.lsp.buf.signature_help)
					map("n", "<leader>D", vim.lsp.buf.type_definition)
					map("n", "<leader>rn", vim.lsp.buf.rename)
					map("n", "gr", references)
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
					map("n", "<leader>e", vim.diagnostic.open_float)
					map("n", "<leader>q", vim.diagnostic.setloclist)
					map("n", "<leader>wq", vim.diagnostic.setqflist)
					map("n", "<leader>so", document_symbols)
					map("n", "<leader>wso", workspace_symbols)
				end,
			})

		end,
	},
}
