return {
	settings = {
		gopls = {
			staticcheck = true,
			analyses = {
				unusedwrite = true,
				composites = false,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
