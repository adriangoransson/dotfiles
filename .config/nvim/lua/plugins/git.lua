return {
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
		},

		init = function()
			vim.g.fugitive_legacy_commands = 0
		end,
	},

	{
		"sindrets/diffview.nvim",
		opts = {
			default_args = {
				DiffviewOpen = { "--imply-local" },
			},
			keymaps = {
				view = {
					{ "n", "q", ":DiffviewClose<cr>" },
				},
				file_panel = {
					{ "n", "q", ":DiffviewClose<cr>" },
				},
			},
		},
		config = function(_, opts)
			require("diffview").setup(opts)

			-- Press enter on an interactive rebase line to open a diff view for that commit.
			vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
				pattern = ".git/rebase-merge/git-rebase-todo",
				callback = function(event)
					vim.keymap.set("n", "<cr>", function()
						local i = 0
						for w in vim.fn.getline("."):gmatch("[^%s]+") do
							if w:sub(1, 1) ~= "-" then -- Ignore flags
								if i == 1 then
									vim.cmd(":DiffviewOpen " .. w .. "^!")
								end

								i = i + 1
							end
						end
					end, {
						buffer = event.buf,
						silent = true,
					})
				end,
			})
		end,
	},
}
