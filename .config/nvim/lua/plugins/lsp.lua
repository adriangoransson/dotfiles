return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- Enable more capabilities from completion plugin if available.
			local ok, blink = pcall(require, "blink.cmp")
			if ok then
				capabilities = blink.get_lsp_capabilities({}, true)
			end

			vim.lsp.config("*", {
				capabilities = capabilities,
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"cssls",
				"gopls",
				"html",
				"lua_ls",
				"rust_analyzer",
				"svelte",
				"ts_ls",
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = {},
	},
}
