return {
	{
		"gregorias/coerce.nvim",
		config = function()
			local c = require("coerce.case")

			local function space_case(str)
				local parts = c.split_keyword(str)
				return table.concat(parts, " ")
			end

			require("coerce").setup({
				cases = {
					{ keymap = "c", case = c.to_camel_case, description = "camelCase" },

					{ keymap = ".", case = c.to_dot_case, description = "dot.case" }, -- abolish mapping.
					{ keymap = "d", case = c.to_dot_case, description = "dot.case" },

					{ keymap = "-", case = c.to_kebab_case, description = "dash-case" }, --abolish mapping.
					{ keymap = "k", case = c.to_kebab_case, description = "kebab-case" },

					{ keymap = "m", case = c.to_pascal_case, description = "MixedCase" }, -- abolish mapping.
					{ keymap = "p", case = c.to_pascal_case, description = "PascalCase" },

					{ keymap = "_", case = c.to_snake_case, description = "snake_case" }, -- abolish mapping.
					{ keymap = "s", case = c.to_snake_case, description = "snake_case" },

					{ keymap = "U", case = c.to_upper_case, description = "UPPER_CASE" }, -- abolish mapping.
					{ keymap = "u", case = c.to_upper_case, description = "UPPER_CASE" },

					{ keymap = " ", case = space_case, description = "space case" }, -- abolish mapping.

					{ keymap = "n", case = c.to_numerical_contraction, description = "numeronym (n7m)" },
					{ keymap = "/", case = c.to_path_case, description = "path/case" },
				},
			})
		end,
	},
}
