return {
	{
		"cormacrelf/dark-notify",
		lazy = false,
		dependencies = {
			"levouh/tint.nvim",
			"cormacrelf/vim-colors-github",
			"folke/tokyonight.nvim",
		},

		config = function()
			local dn = require("dark_notify")
			local tint = require("tint")

			local function set_dark_theme()
				vim.cmd([[
					highlight clear
					set background=dark
					colorscheme tokyonight-moon
				]])
				tint.refresh()
			end

			local function set_light_theme()
				vim.cmd([[
					highlight clear
					set background=light
					colorscheme github
					highlight link LspSignatureActiveParameter CursorLine
					highlight link @text.diff.add DiffAdd
					highlight link @text.diff.delete DiffRemoved
					highlight Whitespace guifg=#d7d7d7 " Softer color for listchars.
					highlight link LspInlayHint Comment
					highlight link Label NONE
					highlight link @punctuation.delimiter Delimiter
					highlight link @punctuation.bracket Delimiter
					highlight Label guifg=#116329
					highlight String guifg=#0a3069
				]])
				tint.refresh()
			end

			local function set_system_theme()
				dn.update()
			end

			dn.run({
				onchange = function(mode)
					if mode == "light" then
						set_light_theme()
					else
						set_dark_theme()
					end
				end,
			})

			vim.api.nvim_create_user_command("SetSystemTheme", set_system_theme, {})
			vim.api.nvim_create_user_command("SetDarkTheme", set_dark_theme, {})
			vim.api.nvim_create_user_command("SetLightTheme", set_light_theme, {})

			vim.api.nvim_create_user_command("TintToggle", tint.toggle, {})
			vim.api.nvim_create_user_command("TintEnable", tint.enable, {})
			vim.api.nvim_create_user_command("TintDisable", tint.disable, {})

			-- Run on first source
			set_system_theme()

			tint.setup({ tint = -20, saturation = 0.55 })
		end,
	},
}
