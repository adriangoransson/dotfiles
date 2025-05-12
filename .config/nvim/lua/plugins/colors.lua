local augroup = require("util").augroup

return {
	{
		"cormacrelf/vim-colors-github",
		lazy = false,
		dependencies = {
			"levouh/tint.nvim",
			"folke/tokyonight.nvim",
		},

		config = function()
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
				local dark_mode = vim.fn.has("mac") == 1
					and vim.fn.system("defaults read -g AppleInterfaceStyle") == "Dark\n"

				if dark_mode then
					set_dark_theme()
				else
					set_light_theme()
				end
			end

			augroup("colorscheme_event_listener", function(au)
				au("Signal", "SIGUSR1", set_system_theme)
			end)

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
