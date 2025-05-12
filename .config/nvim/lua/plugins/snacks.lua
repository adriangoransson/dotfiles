local files_args = {}
if vim.fn.executable("fd") or vim.fn.executable("rg") then
	files_args = { "--no-ignore-vcs" }
end

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,

	---@module 'snacks'
	---@type snacks.Config
	opts = {
		input = {
			icon_pos = false,
			win = {
				relative = "cursor",
				row = -3,
				col = -2,
				width = 30,
			},
		},
		picker = {},
	},

	keys = {
		{
			"<leader>p",
			function()
				Snacks.picker.smart({
					multi = {
						{ source = "files", args = files_args },
						"buffers",
						"recent",
					},
					filter = {
						cwd = true,
					},
					hidden = true,
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
