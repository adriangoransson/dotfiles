return {
	"jghauser/mkdir.nvim",
	"tpope/vim-eunuch",

	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["<C-s>"] = false,
				["<C-h>"] = false,
				["<C-l>"] = false,
				["<C-r>"] = "actions.refresh",
			},
			view_options = {
				show_hidden = true,
			},
		},
	},
}
