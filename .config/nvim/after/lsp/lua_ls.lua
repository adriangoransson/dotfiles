return {
	settings = {
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
}
