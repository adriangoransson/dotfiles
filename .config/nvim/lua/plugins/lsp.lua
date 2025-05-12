return {
	{
		"neovim/nvim-lspconfig",
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
