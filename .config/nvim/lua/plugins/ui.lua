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

	{ "echasnovski/mini.notify", opts = {} },

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"fugitive",
					"TelescopePrompt",
				},
			})
		end,
	},
}
