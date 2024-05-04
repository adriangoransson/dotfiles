return {
	"folke/zen-mode.nvim",

	{
		"smjonas/live-command.nvim",
		event = "VeryLazy",
		main = "live-command",
		opts = {
			commands = {
				GG = { cmd = "g" }, -- fugitive maps G.
				Norm = { cmd = "norm" },
			},
		},
	},

	{
		"tversteeg/registers.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				-- When true, <Esc> will close the modal
				insert_only = false,
				win_options = {
					winblend = 0,
				},
			},
		},
	},

	{ "echasnovski/mini.notify", opts = {} },
}
