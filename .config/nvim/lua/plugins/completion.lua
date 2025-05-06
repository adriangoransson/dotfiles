return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"xzbdmw/colorful-menu.nvim",
			"folke/lazydev.nvim",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
			},

			completion = {
				list = {
					selection = {
						auto_insert = false,
					},
				},
				documentation = {
					auto_show = true,
				},
				menu = {
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", gap = 1 },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},

			signature = {
				enabled = true,
			},

			sources = {
				default = { "lazydev", "lsp", "path", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},

			cmdline = {
				enabled = false,
			},
		},
	},

	{
		"xzbdmw/colorful-menu.nvim",
		opts = {},
	},
}
