return {
	"jghauser/mkdir.nvim",
	"tpope/vim-eunuch",

	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				-- Replace built-in ctrl-w commands.
				["<C-w>v"] = { "actions.select", opts = { vertical = true } },
				["<C-w>s"] = { "actions.select", opts = { horizontal = true } },
				["<C-w>t"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["-"] = { "actions.parent", mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
			},
		},
		config = function(_, opts)
			local oil = require("oil")
			oil.setup(opts)

			-- Auto-enable preview: https://github.com/stevearc/oil.nvim/issues/87
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilEnter",
				callback = vim.schedule_wrap(function(args)
					if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
						oil.open_preview()
					end
				end),
			})
		end,
	},
}
