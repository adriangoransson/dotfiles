local finder = function()
	if 1 == vim.fn.executable("fd") then
		return {
			"fd",
			"--hidden",
			"--no-ignore-vcs",
			"--strip-cwd-prefix",
			"--type",
			"f",
			"--color",
			"never",
			"--exclude",
			".git/",
			"--exclude",
			"node_modules/",
		}
	elseif 1 == vim.fn.executable("rg") then
		return {
			"rg",
			"--hidden",
			"--no-ignore-vcs",
			"--files",
			"--color",
			"never",
			"--glob",
			"!.git/",
			"--glob",
			"!node_modules/",
		}
	elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
		return {
			"find",
			".",
			"-type",
			"f",
			"-not",
			"-path",
			"*.git/*",
			"-not",
			"-path",
			"*node_modules/*",
		}
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"natecraddock/telescope-zf-native.nvim",
		},

		keys = {
			{ "<leader>p", ":Telescope find_files<cr>", silent = true },
			{ "<leader>b", ":Telescope buffers<cr>", silent = true },
		},

		config = function()
			local ts = require("telescope")

			ts.setup({
				defaults = {
					mappings = {
						i = {
							["<C-c>"] = false,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = finder(),
					},
					buffers = {
						mappings = {
							n = {
								["D"] = "delete_buffer",
							},
						},
					},
				},

				-- This will load fzy_native and have it override the default file sorter
				ts.load_extension("zf-native"),
			})
		end,
	},
}
