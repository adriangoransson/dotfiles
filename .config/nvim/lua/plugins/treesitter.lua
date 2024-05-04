return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"awk",
				"bash",
				"c",
				"comment",
				"css",
				"diff",
				"dockerfile",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"htmldjango",
				"http",
				"ini",
				"javascript",
				"jq",
				"json",
				"json5",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"luau",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"regex",
				"rust",
				"sql",
				"svelte",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},

			auto_install = true,

			highlight = {
				enable = true,

				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
		},
	},

	{
		"AckslD/nvim-trevJ.lua",
		dependencies = { "nvim-treesitter/nvim-treesitter" },

		config = function()
			vim.keymap.set("n", "<leader>j", require("trevj").format_at_cursor, { silent = true })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},

	{
		"nvim-treesitter/playground",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
