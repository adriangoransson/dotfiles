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
			"natecraddock/telescope-zf-native.nvim",
			"nvim-lua/plenary.nvim",

			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},

		keys = {
			{ "<leader>p", ":Telescope find_files<cr>", silent = true },
			{ "<leader>b", ":Telescope buffers<cr>", silent = true },
		},

		config = function()
			local ts = require("telescope")

			ts.setup({
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

				extensions = {
					fzf = {
						override_file_sorter = false,
					},

					["zf-native"] = {
						generic = {
							enable = false,
						},
					},
				},
			})

			ts.load_extension("fzf")
			ts.load_extension("zf-native")
		end,
	},
}
