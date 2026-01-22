return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-t><C-t>]],
				on_open = function()
					-- Always enter insert mode when a terminal is shown.
					-- https://github.com/akinsho/toggleterm.nvim/issues/522
					vim.fn.timer_start(0, function()
						vim.cmd("startinsert!")
					end)
				end,
				shell = "fish",
			})

			local function create_term(direction)
				require("toggleterm.terminal").Terminal:new():toggle(nil, direction)
			end

			vim.keymap.set("n", "<C-t><C-f>", function()
				create_term("float")
			end)

			vim.keymap.set("n", "<C-t><C-d>", function()
				vim.ui.select({ "vertical", "horizontal", "tab", "float" }, {}, function(direction)
					if not direction then
						return
					end

					create_term(direction)
				end)
			end)
		end,
	},
}
