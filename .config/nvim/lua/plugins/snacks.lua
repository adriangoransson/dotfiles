return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		input = {},
		picker = {},
	},
	keys = {
		{
			"<leader>p",
			function()
				Snacks.picker.smart({
					filter = {
						cwd = true,
					},
				})
			end,
		},

		{
			"<leader>b",
			function()
				Snacks.picker.buffers({
					actions = {},
				})
			end,
		},

		{
			"<leader>rc",
			function()
				Snacks.picker.recent()
			end,
		},
	},
}
